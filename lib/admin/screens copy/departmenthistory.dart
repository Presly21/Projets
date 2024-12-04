import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexmax_hrms/admin/screens%20copy/adddepartment.dart';
import 'package:nexmax_hrms/admin/screens%20copy/employeehistory.dart';

class Department {
  final String name;
  int numberOfEmployees;
  final List<String> employeeAvatars;

  Department({
    required this.name,
    required this.numberOfEmployees,
    required this.employeeAvatars,
  });
}


class DepartmentDetailPage extends StatelessWidget {
  final Department department;

  DepartmentDetailPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(department.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Department: ${department.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Employee')
                  .where('department', isEqualTo: department.name)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No employees found for this department.'));
                }

                List<DocumentSnapshot> employees = snapshot.data!.docs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: employees.map((employee) {
                    var data = employee.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        const Divider(),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: data['profilePicture'] != null
                                ? NetworkImage(data['profilePicture'])
                                : const AssetImage('assets/images/default_avatar.jpg') as ImageProvider,
                          ),
                          title: Text(data['fullName'] ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Role: ${data['role'] ?? 'N/A'}'),
                              Text('Position: ${data['position'] ?? 'N/A'}'),
                              Text('Phone Number: ${data['phoneNumber'] ?? 'N/A'}'),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            color: Colors.white,
                            onSelected: (value) {
                              if (value == 'Edit') {
                                // Naviguer vers la page d'édition avec l'ID du document
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditEmployeePage(documentId: employee.id),
                                  ),
                                );
                              } else if (value == 'Delete') {
                                // Supprimer l'employé
                                _deleteEmployee(employee.id);
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Edit', 'Delete'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                          onTap: () {
                            // Naviguer vers la page de détail avec l'ID du document
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeDetailPage(documentId: employee.id),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteEmployee(String documentId) {
    FirebaseFirestore.instance.collection('Employee').doc(documentId).delete();
  }
}

class EditEmployeePage extends StatelessWidget {
  final String documentId;

  // ignore: use_super_parameters
  const EditEmployeePage({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
      ),
      body: Center(
        child: Text('Edit employee with ID: $documentId'),
      ),
    );
  }
}

class EmployeeDetailPage extends StatelessWidget {
  final String documentId;

  // ignore: use_super_parameters
  const EmployeeDetailPage({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee Detail'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Employee').doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Employee not found!'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              _buildDetailItem('Short Name', data['shortName']),
              _buildDetailItem('Full Name', data['fullName']),
              _buildDetailItem('Profile Picture', data['profilePicture'], isImage: true),
              _buildDetailItem('Role', data['role']),
              _buildDetailItem('Position', data['position']),
              _buildDetailItem('Phone Number', data['phoneNumber']),
              _buildDetailItem('Date of Birth', _formatTimestamp(data['dateOfBirth'])),
              _buildDetailItem('Nationality', data['nationality']),
              _buildDetailItem('Email', data['Email']),
              _buildDetailItem('Gender', data['gender']),
              _buildDetailItem('Race', data['race']),
              _buildDetailItem('Marital Status', data['maritalStatus']),
              _buildDetailItem('Religion', data['religion']),
              _buildDetailItem('Department', data['department']),
            ],
          );
        },
      ),
    );
  }

  String? _formatTimestamp(Timestamp? timestamp) {
    if (timestamp != null) {
      DateTime dateTime = timestamp.toDate();
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
    return null;
  }

  Widget _buildDetailItem(String label, dynamic value, {bool isImage = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5.0),
          isImage && value != null
              ? _buildImage(value)
              : Text(
                  value != null ? value.toString() : 'N/A',
                  style: const TextStyle(fontSize: 16.0),
                ),
        ],
      ),
    );
  }

  Widget _buildImage(String value) {
    if (value.startsWith('http') || value.startsWith('https')) {
      return Image.network(
        value,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 150);
        },
      );
    } else {
      return Image.file(
        File(value),
        height: 150,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 150);
        },
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: EmployeeListPage(),
  ));
}
// ignore: use_key_in_widget_constructors
class DepartmentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('departments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Department> departments = snapshot.data!.docs.map((doc) {
            return Department(
              name: doc['name'],
              numberOfEmployees: 0, // Placeholder until actual count is fetched
              employeeAvatars: [], // Placeholder until actual avatars are fetched
            );
          }).toList();

          // Function to fetch real employee count for each department
          Future<void> fetchEmployeeCounts() async {
            for (var department in departments) {
              var querySnapshot = await FirebaseFirestore.instance
                  .collection('Employee')
                  .where('department', isEqualTo: department.name)
                  .get();

              department.numberOfEmployees = querySnapshot.docs.length;
            }
          }

          // Fetch employee counts and update UI
          fetchEmployeeCounts();

          return SingleChildScrollView(
            child: Column(
              children: departments
                  .map((department) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DepartmentDetailPage(department: department),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            department.name,
                                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8.0),
                                          FutureBuilder(
                                            future: fetchEmployeeCounts(),
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              return Text('Number of Employees: ${department.numberOfEmployees}');
                                            },
                                          ),
                                        ],
                                      ),
                                      PopupMenuButton<String>(
                                        color: Colors.white,
                                        onSelected: (value) {
                                          // Handle the selection here
                                          if (value == 'Edit') {
                                            // Navigate to the edit page or perform edit action
                                          } else if (value == 'Delete') {
                                            // Perform delete action
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return {'Edit', 'Delete'}
                                              .map((String choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  SizedBox(
                                    height: 50.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: department.employeeAvatars.length,
                                      itemBuilder: (context, avatarIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 6.0),
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: AssetImage(department.employeeAvatars[avatarIndex]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DepartmentFormPage()),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add'),
          backgroundColor: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
