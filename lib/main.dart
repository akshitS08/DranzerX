import 'package:dranzerx/home_page.dart';
import 'package:dranzerx/pallete.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(context) {
    return MaterialApp(
      title: 'DranzerX',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: AppBarTheme(backgroundColor: Pallete.whiteColor,),
      ),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}

