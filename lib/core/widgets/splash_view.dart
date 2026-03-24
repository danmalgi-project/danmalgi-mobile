import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

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
