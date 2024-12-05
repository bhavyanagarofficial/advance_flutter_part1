import 'dart:async';
import 'package:advance_flutter_exam_part_1/country/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFB3E5FC),
                Color(0xFF64B5F6),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/country.json',
                  height: height * 0.5,
                ),
                const SizedBox(height: 20),
                Text(
                  'One Country, One Spirit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black38,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: width * 0.6,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
