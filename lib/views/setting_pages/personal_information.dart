import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/gradeinet_background.dart';
import '../../constants/page_navigation.dart';
import '../../constants/text_style.dart';
import '../../constants/time_date_functions.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import 'components/setting_list_tile.dart';
import 'passport_copy.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final UserModel _userData = Get.find<AuthController>().userData.value;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Personal Information',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const SettingListTile(
                text: 'Personal Information',
                trailing: 'MY 001',
              ),
              if (_userData.dateOfBirth != null)
                SettingListTile(
                  text: 'Date of Birth',
                  trailing: TimeDateFunctions.dateTimeInDigitsWithForwardDash(
                      _userData.dateOfBirth!),
                ),
              const SizedBox(height: 20),
              if (_userData.employementData?.dateJoined != null)
                SettingListTile(
                  text: 'Date Joined',
                  trailing: TimeDateFunctions.dateTimeInDigitsWithForwardDash(
                      _userData.employementData!.dateJoined!),
                ),
              if (_userData.nationality != null)
                SettingListTile(
                  text: 'Nationality',
                  trailing: _userData.nationality!,
                ),
              if (_userData.passportNumber != null)
                SettingListTile(
                  text: 'Passport Number',
                  trailing: _userData.passportNumber!,
                ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.3,
                  ),
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Go.to(() => const PassportCopy());
                  },
                  title: Text(
                    "PPT Copy",
                    style: CustomTextStyles.bodyTextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              if (_userData.passportExpiryDate != null)
                SettingListTile(
                  text: 'Passport Expired',
                  trailing: TimeDateFunctions.dateTimeInDigitsWithForwardDash(
                      _userData.passportExpiryDate!),
                ),
              const SizedBox(height: 20),
              if (_userData.gender != null)
                SettingListTile(
                  text: 'Gender',
                  trailing: _userData.gender!,
                ),
              if (_userData.race != null)
                SettingListTile(
                  text: 'Race',
                  trailing: _userData.race!,
                ),
              if (_userData.maritalStatus != null)
                SettingListTile(
                  text: 'Martial Status',
                  trailing: _userData.maritalStatus!,
                ),
              if (_userData.religion != null)
                SettingListTile(
                  text: 'Religion',
                  trailing: _userData.religion!,
                ),
              if (_userData.userId != null)
                SettingListTile(
                  text: 'User ID',
                  trailing: _userData.userId!.toString(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
