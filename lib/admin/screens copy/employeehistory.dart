import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexmax_hrms/admin/screens%20copy/addemployee.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

// ignore: use_key_in_widget_constructors
class EmployeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Lists'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Employee').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(data['fullName'] ?? ''),
                  subtitle: Text(data['role'] ?? ''),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor:
                        data['profilePicture'] == null ? Colors.blue : null,
                    backgroundImage: data['profilePicture'] != null
                        ? NetworkImage(data['profilePicture'])
                        : null,
                    child: data['profilePicture'] == null &&
                            data['fullName'] != null
                        ? Text(
                            data['fullName']
                                [0], // Affiche la première lettre du nom
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          )
                        : null,
                  ),
                  trailing: PopupMenuButton<String>(
                    color: Colors.white,
                    onSelected: (value) {
                      if (value == 'Edit') {
                        // Navigate to edit page with document id
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditEmployeePage(
                                  documentId: documents[index].id)),
                        );
                      } else if (value == 'Delete') {
                        // Perform delete action
                        _deleteEmployee(documents[index].id);
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
                    // Navigate to detail page with document id
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeDetailPage(
                              documentId: documents[index].id)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeFormPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteEmployee(String documentId) {
    FirebaseFirestore.instance.collection('Employee').doc(documentId).delete();
  }
}

class EditEmployeePage extends StatelessWidget {
  final String documentId;

  // ignore: use_key_in_widget_constructors
  const EditEmployeePage({required this.documentId});

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
  const EmployeeDetailPage({Key? key, required this.documentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee Detail'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Employee')
            .doc(documentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Employee not found!'));
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              _buildDetailItem('Short Name', data['shortName']),
              _buildDetailItem('Full Name', data['fullName']),
              _buildDetailItem('Profile Picture', data['profilePicture'],
                  isImage: true),
              _buildDetailItem('Role', data['role']),
              _buildDetailItem('Position', data['position']),
              _buildDetailItem('Phone Number', data['phoneNumber']),
              _buildDetailItem(
                  'Date of Birth', _formatTimestamp(data['dateOfBirth'])),
              _buildDetailItem('Nationality', data['nationality']),
              _buildDetailItem('Email', data['email']),
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
