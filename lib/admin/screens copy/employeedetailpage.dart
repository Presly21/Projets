import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class EmployeeDetailPage extends StatelessWidget {
  final DocumentSnapshot employee;

  // ignore: use_super_parameters
  const EmployeeDetailPage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = employee.data() as Map<String, dynamic>;

    String? profilePicturePath = data['profilePicture'];
    File? profilePictureFile;
    if (profilePicturePath != null && profilePicturePath.isNotEmpty) {
      profilePictureFile = File(profilePicturePath);
    }

    Timestamp? dateOfBirthTimestamp = data['dateOfBirth'];
    String? dateOfBirthString;
    if (dateOfBirthTimestamp != null) {
      dateOfBirthString = dateOfBirthTimestamp.toDate().toIso8601String().substring(0, 10);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            profilePictureFile != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(profilePictureFile),
                  )
                : const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person),
                  ),
            const SizedBox(height: 20),
            Text('Short Name: ${data['shortName'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Full Name: ${data['fullName'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Role: ${data['role'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Position: ${data['position'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Lifetime: ${data['lifetime'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Date of Birth: ${dateOfBirthString ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Nationality: ${data['nationality'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Email: ${data['email'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Phone Number: ${data['phoneNumber'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Gender: ${data['gender'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Race: ${data['race'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Marital Status: ${data['maritalStatus'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Religion: ${data['religion'] ?? 'N/A'}'),
            const SizedBox(height: 10),
            Text('Department: ${data['department'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
