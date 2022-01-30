

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todowithgetx/Moduels/Home%20Screen/homescreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasySplashScreen(
        logo: Image.asset('assets/image/appicon.jpeg'),
        logoSize: 50,
        backgroundColor: Get.isDarkMode ? Colors.black45 : Colors.white,
        title: Text(
            'Organize you\'r Time with us',
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        loaderColor: Get.isDarkMode ? Colors.white : Colors.black,
        navigator: HomeScreen(),
        durationInSeconds: 3,
      ),
    );
  }
}
