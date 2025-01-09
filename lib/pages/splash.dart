import 'package:flutter/material.dart';
import 'package:ml_zone/pages/home_page.dart';
import '../utils/custom_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBGColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Scan Verse!",
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your ultimate partner for productive and easy life!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.all(20),
              width: size.width * 0.6, // Scaled to 60% of screen width
              decoration: BoxDecoration(
                border: Border.all(color: primaryTextColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/images/bg_home.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
