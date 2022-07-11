import 'package:flutter/material.dart';
import 'package:phpfluttercourse/app/auth/login.dart';
import 'package:phpfluttercourse/app/auth/signup.dart';
import 'package:phpfluttercourse/app/auth/success.dart';
import 'package:phpfluttercourse/app/home.dart';
import 'package:phpfluttercourse/app/notes/add.dart';
import 'package:phpfluttercourse/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedP;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedP = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PHP FLUTTER Course API',
      initialRoute: sharedP.getString("id") == null ? "login" : "home",

      routes: {
        "home": (context) => Home(),
        "success": (context) => Success(),
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "addNotes": (context) => AddNotes(),
        "editNotes": (context) => EditNotes(),
      },
    );
  }
}
