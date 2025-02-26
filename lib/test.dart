import 'package:flutter/material.dart';
import '/widgets/actions/bla_button.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

/// Main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}

/// Home screen displaying different buttons.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlaButton(
              text: "Primary Button",
              onPressed: () => print("Primary Button Pressed"),
            ),
            BlaButton(
              type: ButtonType.secondary,
              text: "Secondary Button",
              onPressed: () {},
            ),
            BlaButton(
              icon: Icons.access_alarm,
              text: "Button with Icon",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
