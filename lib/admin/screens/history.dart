// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView(
        children: [
          _buildHistoryItem('Announcement', 'This is a fake announcement.'),
          _buildHistoryItem('Auth Screen', 'Auth event happened.'),
          _buildHistoryItem('Home', 'Home page accessed.'),
          _buildHistoryItem('Attendance', 'Attendance marked.'),
          _buildHistoryItem('Leaves', 'Leave request submitted.'),
          _buildHistoryItem('Notebook', 'Note added.'),
          _buildHistoryItem('Pay Slip', 'Pay slip generated.'),
          _buildHistoryItem('Salary', 'Salary credited.'),
          _buildHistoryItem('Add User', 'New user added.'),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String description) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
