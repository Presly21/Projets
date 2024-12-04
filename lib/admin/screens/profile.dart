import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          _buildProfileItem('Name', 'John Doe'),
          _buildProfileItem('Email', 'john.doe@example.com'),
          _buildProfileItem('Position', 'Admin'),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
