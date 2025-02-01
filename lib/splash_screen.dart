// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task/features/auth/presentation/pages/login_screen.dart';
import 'package:task/features/dash_board/presentation/pages/dash_board_screen.dart';
import 'package:task/session_controller/session_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _isLoing() async {
    await Future.delayed(Duration(seconds: 2));

    final sessionManager = SecureStorageSession();

    final res = await sessionManager.getSession();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => res != null ? DashBoardScreen() : LoginScreen(),
        ));
  }

  @override
  void initState() {
    _isLoing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
