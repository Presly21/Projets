import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexmax_hrms/constants/gradeinet_background.dart';
import 'package:nexmax_hrms/views/home/homepage.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../utilities/widgets/custom_dialog.dart';
import '../leaves/leave_page.dart';
import '../notebook/notebook_page.dart';
import '../pay_slip/pay_slip.dart';
import '../salary/advance_salary.dart';

class BottomBar extends StatefulWidget {
  // ignore: use_super_parameters
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> { 
  final List<Widget> _pages = [
    const HomePageEmpl(),
    const LeavePage(),
    const PaySlipPage(),
    const AdvanceSalaryPage(),
    const NoteBookPage(),
  ];
@override
  void initState() {
    super.initState();
  }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _willPop() async {
    var res = await CustomDialogBox.confirmationDialog(
      context: context,
      title: 'Are You Sure You Want to Exit the App',
      btnYesPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        true;
      },
      btnNoPressed: () {
        Get.back();
        false;
      },
    );
    return res ?? false; // Return false if res is null
  }

  @override
  Widget build(BuildContext context) {
    List<ImageProvider> iconAssets = [
      const AssetImage(AppAssets.home),
      const AssetImage(AppAssets.leave),
      const AssetImage(AppAssets.paySlip),
      const AssetImage(AppAssets.advanceSalary),
      const AssetImage(AppAssets.noteBook),
    ];

    List<Widget> icons = List.generate(iconAssets.length, (index) {
      return Image(
        image: iconAssets[index],
        width: 34,
        height: 34,
        color: _selectedIndex == index ? AppColors.secondary : Colors.white,
      );
    });

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _willPop,
      child: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _pages[_selectedIndex],
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                for (int i = 0; i < icons.length; i++)
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(i);
                    },
                    child: SizedBox(
                      height: 40,
                      width: 100.w / 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          icons[i],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
