import 'package:app_api/app/page/OnBoarding/Onboarding.dart';
import 'package:app_api/app/page/register.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:app_api/app/page/auth/OTP.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
      // initialRoute: "/",
      // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
    );
  }
}
