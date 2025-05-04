import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/view/home_screen.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/view/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      home: SplashScreen(),
    );
  }
}
