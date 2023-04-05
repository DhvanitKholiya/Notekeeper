import 'dart:async';

import 'package:flutter/material.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({Key? key}) : super(key: key);

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      Navigator.of(context).pushReplacementNamed('login');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 400,end: 0),
              duration: const Duration(seconds: 5),
              curve: Curves.bounceIn,
              builder: (context,double degree,widget){
                return Transform.translate(offset: Offset(degree, 0),child: widget,);
              },
              child: Image.asset(
                'Assets/My_Images/Screenshot_37-removebg-preview.png',
                height: 100,
                width: 100,
              ),
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0,end: 1),
              duration: const Duration(seconds: 7),
              curve: Curves.easeInOut,
              builder: (context,double val,widget)  {
                return Transform.scale(
                  scale: val,
                  child: widget,
                );
              },
              child: Image.network(
                'https://cdn.iconscout.com/icon/free/png-256/firebase-3628772-3030134.png',
                fit: BoxFit.scaleDown,
                color: Colors.orange.withOpacity(0.2),
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            const Align(
              alignment: Alignment(0, 0.8),
              child: Text(
                "Notekeeper",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.brown,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
