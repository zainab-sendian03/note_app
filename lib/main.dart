import 'package:flutter/material.dart';
import 'package:note_application/app/home.dart';
import 'package:note_application/auth/login.dart';
import 'package:note_application/auth/signup.dart';
import 'package:note_application/note/add.dart';
import 'package:note_application/note/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note',
      initialRoute: pref.getString('id') == null ? "/login" : "/home",
      routes: {
        "/login": (context) => const login(),
        "/signup": (context) => const signup(),
        "/home": (context) => const Home(),
        "/add": (context) => const add_note(),
        "/edit": (context) => const edit_note(),
      },
    );
  }
}
