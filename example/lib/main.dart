import 'package:enchant_button/enchant_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// The main application widget.
// This widget initializes the Flutter application and sets up the root widget tree.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animation Button Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RadioButtonBounce example
              RadioButtonBounce(
                size: 50,
                onTap: () {
                  // Handle tap event
                },
              ),
              const SizedBox(height: 20),
              // AddFavoriteButton example
              AddFavoriteButton(
                size: 100,
                onTap: () {
                  // Handle tap event
                },
              ),
              const SizedBox(height: 20),
              // Neon3DButton example
              Neon3DButton(
                icon: Icons.power_settings_new_rounded,
                size: 100,
                onTap: () {
                  // Handle tap event
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
