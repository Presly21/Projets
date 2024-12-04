import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: use_key_in_widget_constructors
class EmployeeFormPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EmployeeFormPageState createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> departments = []; // List to store departments
  // Form controllers
  final TextEditingController shortNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController lifetimeController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController raceController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  String? department;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _selectDepartment() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('departments').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<String> departments = snapshot.data!.docs.map((doc) => doc['name'] as String).toList();
            return ListView.builder(
              itemCount: departments.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(departments[index]),
                  onTap: () {
                    setState(() {
                      department = departments[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateOfBirthController.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection('Employee').add({
          'shortName': shortNameController.text,
          'fullName': fullNameController.text,
          'profilePicture': _imageFile?.path,
          'role': roleController.text,
          'position': positionController.text,
          'lifetime': int.tryParse(lifetimeController.text),
          'dateOfBirth': Timestamp.fromDate(DateTime.parse(dateOfBirthController.text)),
          'nationality': nationalityController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'gender': genderController.text,
          'race': raceController.text,
          'maritalStatus': maritalStatusController.text,
          'religion': religionController.text,
          'department': department,
          'createdAt': Timestamp.now(),
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context); // Example: pop back to previous screen
      } catch (e) {
        // ignore: avoid_print
        print('Error saving employee: $e');
        // Handle error, e.g., show an error dialog
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    shortNameController.dispose();
    fullNameController.dispose();
    roleController.dispose();
    positionController.dispose();
    lifetimeController.dispose();
    dateOfBirthController.dispose();
    nationalityController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    raceController.dispose();
    maritalStatusController.dispose();
    religionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                labelText: 'Short Name',
                hintText: 'Enter short name',
                controller: shortNameController,
              ),
              _buildTextFormField(
                labelText: 'Full Name',
                hintText: 'Enter full name',
                controller: fullNameController,
              ),
              _buildProfilePictureField(),
              _buildTextFormField(
                labelText: 'Role',
                hintText: 'Enter role',
                controller: roleController,
              ),
              _buildTextFormField(
                labelText: 'Position',
                hintText: 'Enter position',
                controller: positionController,
              ),
              _buildTextFormField(
                labelText: 'Lifetime',
                hintText: 'Enter lifetime',
                keyboardType: TextInputType.number,
                controller: lifetimeController,
              ),
              _buildDateOfBirthField(),
              _buildTextFormField(
                labelText: 'Nationality',
                hintText: 'Enter nationality',
                controller: nationalityController,
              ),
              _buildTextFormField(
                labelText: 'Email',
                hintText: 'Enter email',
                controller: emailController,
              ),
              _buildTextFormField(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                controller: phoneNumberController,
              ),
              _buildTextFormField(
                labelText: 'Gender',
                hintText: 'Enter gender',
                controller: genderController,
              ),
              _buildTextFormField(
                labelText: 'Race',
                hintText: 'Enter race',
                controller: raceController,
              ),
              _buildTextFormField(
                labelText: 'Marital Status',
                hintText: 'Enter marital status',
                controller: maritalStatusController,
              ),
              _buildTextFormField(
                labelText: 'Religion',
                hintText: 'Enter religion',
                controller: religionController,
              ),
              _buildDepartmentField(),
              Center(
                child: ElevatedButton(
                  onPressed: _saveEmployee,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
        controller: controller,
      ),
    );
  }

  Widget _buildProfilePictureField() {
    return GestureDetector(
      onTap: _pickImage,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            _imageFile != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(_imageFile!.path)),
                  )
                : const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.camera_alt),
                  ),
            const SizedBox(width: 20),
            const Text(
              'Select Profile Picture',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return GestureDetector(
      onTap: () => _selectDateOfBirth(context),
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            controller: dateOfBirthController,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              hintText: 'Select date of birth',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date of birth';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentField() {
    return GestureDetector(
      onTap: _selectDepartment,
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Department',
              hintText: department ?? 'Select department',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (department == null) {
                return 'Please select a department';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EmployeeFormPage(),
  ));
}