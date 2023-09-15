import 'dart:async';
import 'package:expenser_app/app_constants.dart';
import 'package:expenser_app/screens/onbording%20screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_widgets/app_form_field.dart';
import '../home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String LOGIN_ID='logInID';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whereToGo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getAppLogoUI(),
            gap(),
            const Text(
              AppConsts.appName,
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppLogoUI() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 64,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          'assets/image/expenses.png',
          color: Colors.white,
        ),
      ),
    );
  }
  void whereToGo() async {
    var pref = await SharedPreferences.getInstance();
    var isLogin = pref.getString(LOGIN_ID);
    Timer(const Duration(seconds: 3), () async {
      // Widget navigateToPage = LoginScreen();
      if (isLogin != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(emailId: isLogin,),));
      }
       else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(),));
          // navigateToPage = SignUpScreen();
        }
    });
  }
  }
