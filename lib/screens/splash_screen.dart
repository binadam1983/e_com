import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5),
        () => Navigator.of(context, rootNavigator: true).popAndPushNamed('/'));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.jpg'),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: size.height * .7),
              const SpinKitThreeBounce(
                color: Colors.black87,
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
