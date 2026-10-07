import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  final String id;
  const SplashView({super.key, this.id = '0'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Splash View ${id}')],
        ),
      ),
    );
  }
}
