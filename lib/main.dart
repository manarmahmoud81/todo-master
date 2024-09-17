import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoo/layout/home_layout.dart';
import 'package:todoo/shared/styles/themeing.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
      },
      themeMode: ThemeMode.light,
      theme: MyThemeData.lightTheme,
    );
  }
}
