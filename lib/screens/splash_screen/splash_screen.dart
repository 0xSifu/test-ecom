import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _turns = 0.05;
  final List<double> _turnsArray = [0.05, 0, -0.05, 0];
  int _currentTurnIndex = 1;

  @override
  void initState() {
    super.initState();
    rotateUfoMan();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Get.offAllNamed(MainScreen.routeName);
    });
  }

  void rotateUfoMan() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _turns = _turnsArray[(_currentTurnIndex) % _turnsArray.length];
        _currentTurnIndex += 1;
      });
      rotateUfoMan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Positioned.fill(child: Image.asset("assets/images/splash/background.png", fit: BoxFit.fill)),
        Positioned.fill(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(flex: sizer.Device.screenType == sizer.ScreenType.tablet ? 3 : 1, child: Container()),
                  Expanded(flex: 3, child: AnimatedRotation(turns: _turns, duration: const Duration(milliseconds: 450), child: Image.asset("assets/images/splash/ufoman.png"))),
                  Expanded(flex: sizer.Device.screenType == sizer.ScreenType.tablet ? 3 : 1, child: Container()),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(flex: sizer.Device.screenType == sizer.ScreenType.tablet ? 3 : 1, child: Container()),
                  Expanded(child: Image.asset("assets/images/splash/logo.png")),
                  Expanded(flex: sizer.Device.screenType == sizer.ScreenType.tablet ? 3 : 1, child: Container()),
                ],
              ),
            ],
          ),
        ))
      ],
    ),
    );
  }
}