// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmax_hrms/admin/screens/history.dart';
import 'package:nexmax_hrms/admin/screens/profile.dart';
import 'package:nexmax_hrms/admin/screens/setting.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildGridTile(context, 'Announcement', Icons.announcement),
          _buildGridTile(context, 'Auth Screen', Icons.screen_lock_landscape),
          _buildGridTile(context, 'Home', Icons.home),
          _buildGridTile(context, 'Attendance', Icons.calendar_today),
          _buildGridTile(context, 'Leaves', Icons.beach_access),
          _buildGridTile(context, 'Notebook', Icons.note),
          _buildGridTile(context, 'Pay Slip', Icons.receipt),
          _buildGridTile(context, 'Salary', Icons.monetization_on),
          _buildGridTile(context, 'Add User', Icons.person_add),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(() => const AdminDashboardScreen());
              break;
            case 1:
              Get.to(() => const HistoryScreen());
              break;
            case 2:
              Get.to(() => const SettingScreen());
              break;
            case 3:
              Get.to(() => const ProfileScreen());
              break;
          }
        },
      ),
    );
  }

  Widget _buildGridTile(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Get.snackbar('Table', 'You tapped on $title');
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
