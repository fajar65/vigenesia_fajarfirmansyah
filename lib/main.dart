// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigenesia_fajarfirmansyah/constants/theme_provider.dart';
import 'package:vigenesia_fajarfirmansyah/screens/welcome_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = false;

    return MaterialApp(
      title: 'Zarr Vision App',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // theme: isDarkMode
      //     ? ThemeData.dark(
      //         useMaterial3: true,
      //       )
      //     : ThemeData.light(
      //         useMaterial3: true,
      //       ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      //   useMaterial3: true,
      // ),
      home: const WelcomeScreen(),
    );
  }
}
