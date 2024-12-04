// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSettingItem('Setting 1', 'Description of setting 1'),
          _buildSettingItem('Setting 2', 'Description of setting 2'),
          _buildSettingItem('Setting 3', 'Description of setting 3'),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String description) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
