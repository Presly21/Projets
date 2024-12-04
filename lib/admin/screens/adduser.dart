import 'package:flutter/material.dart';
import 'package:nexmax_hrms/models/user_model.dart';

class AddUserScreen extends StatelessWidget {
  final int? userId;
  final String? shortName;
  final String? fullName;
  final String? loginId;
  final String? profilePicture;
  final EmployementData? employementData;
  final ContactData? contactData;
  final String? role;
  final String? position;
  final LeaveData? leaveData;
  final String? team;
  final FinanceData? financeData;
  final DateTime? lastLoginAt;
  final int? lifetime;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? passportNumber;
  final DateTime? passportExpiryDate;
  final String? passportCopy;
  final String? gender;
  final String? race;
  final String? maritalStatus;
  final String? religion;

  // ignore: use_key_in_widget_constructors
  const AddUserScreen({
    this.userId,
    this.shortName,
    this.fullName,
    this.loginId,
    this.profilePicture,
    this.employementData,
    this.contactData,
    this.role,
    this.position,
    this.leaveData,
    this.team,
    this.financeData,
    this.lastLoginAt,
    this.lifetime,
    this.dateOfBirth,
    this.nationality,
    this.passportNumber,
    this.passportExpiryDate,
    this.passportCopy,
    this.gender,
    this.race,
    this.maritalStatus,
    this.religion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Short Name', shortName),
            _buildTextField('Full Name', fullName),
            _buildTextField('Login ID', loginId),
            _buildTextField('Profile Picture', profilePicture),
            _buildTextField('Role', role),
            _buildTextField('Position', position),
            _buildTextField('Team', team),
            _buildTextField('Nationality', nationality),
            _buildTextField('Passport Number', passportNumber),
            _buildTextField('Gender', gender),
            _buildTextField('Race', race),
            _buildTextField('Marital Status', maritalStatus),
            _buildTextField('Religion', religion),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        controller: TextEditingController(text: initialValue),
      ),
    );
  }
}
