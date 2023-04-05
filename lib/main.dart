import 'package:flutter/material.dart';
import 'package:notekeeper/views/screens/Homepage.dart';
import 'package:notekeeper/views/screens/Loginpage.dart';
import 'package:notekeeper/views/screens/SignUpPage.dart';
import 'package:notekeeper/views/screens/editPage.dart';
import 'package:notekeeper/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        '/' : (context) => const HomePage(),
        'splash' : (context) => const splash_Screen(),
        'login' : (context) => const LogInPage(),
        'signUp' : (context) => const SignUpPage(),
        'editPage' : (context) => const EditPage(),
      },
    )
  );
}