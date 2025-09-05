import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SETTINGS")),
      body: Center(
        child: Image(
          image: AssetImage('lib/images/login-7101076_1280.png'),
        ),
      ),
    );
  }
}