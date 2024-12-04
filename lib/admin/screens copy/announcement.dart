import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: use_key_in_widget_constructors
class AnnouncementForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AnnouncementFormState createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final _formKey = GlobalKey<FormState>();

  int? id;
  int? announcementId;
  int? teamId;
  int? userId;
  int? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? message;
  String? visibility;
  int? pinned;
  String? selectedDepartment;
  File? _selectedFile;

  final List<String> departments = [
    'HR',
    'Sales',
    'IT',
    'Finance',
    'Marketing'
  ];

  void _selectDepartment() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: departments.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(departments[index]),
              onTap: () {
                setState(() {
                  selectedDepartment = departments[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Créer une Annonce',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => title = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => message = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Visibilité',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => visibility = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la visibilité';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Épinglé (0 ou 1)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => pinned = int.tryParse(value ?? '0'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez indiquer si l\'annonce est épinglée';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildDepartmentField(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickFile,
                  child: const Text('Importer une image ou un fichier'),
                ),
                const SizedBox(height: 20),
                if (_selectedFile != null) _buildFilePreview(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Soumettre l'annonce
                      // ignore: avoid_print
                      print(
                          'Annonce soumise : $title, $message, $visibility, $pinned, $selectedDepartment');
                    }
                  },
                  child: const Text('Soumettre'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: _selectDepartment,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Department',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(selectedDepartment ?? 'Select Department'),
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    return Container(
      width: 100,
      height: 180,
      color: Colors.grey.withOpacity(0.1),
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200 * 0.8,
        child: _selectedFile!.path.endsWith('.pdf')
            ? Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: const Icon(
                  FontAwesomeIcons.filePdf,
                  size: 50,
                  color: Colors.white,
                ))
            : _selectedFile!.path.endsWith('.jpg') ||
                    _selectedFile!.path.endsWith('.png')
                ? Image.file(
                    _selectedFile!,
                    fit: BoxFit.contain,
                  )
                : const Icon(Icons.insert_drive_file,
                    size: 50, color: Colors.white),
      ),
    );
  }
}
