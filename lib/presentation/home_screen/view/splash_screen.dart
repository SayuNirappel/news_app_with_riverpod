import 'package:flutter/material.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade700,
      body: Center(
        child: Text(
          "News 360",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }
}
