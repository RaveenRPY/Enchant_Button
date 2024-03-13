// Copyright (c) 2020, Raveen P. Yatalamaththa. All rights reserved.

// A collection of customizable buttons with eye-catching animations.
// Use this package to elevate your Flutter UI with smooth and interactive animated buttons.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Neon3DButton extends StatefulWidget {
  // Parameters for Neon3DButton Widget
  final IconData? icon; // Icon data for the button
  final double? size; // Size of the button
  final Function? onTap; // Callback function for onTap event
  final Function? onLongPress; // Callback function for onLongPress event
  final Function? onDoubleTap; // Callback function for onDoubleTap event

  // Constructor for Neon3DButton Widget
  const Neon3DButton(
      {super.key,
      this.icon,
      this.size,
      this.onTap,
      this.onLongPress,
      this.onDoubleTap});

  @override
  _Neon3DButtonState createState() => _Neon3DButtonState();
}

class _Neon3DButtonState extends State<Neon3DButton> {
  Artboard? riveArtboard; // Artboard for Rive animation
  SMITrigger? isPressed; // State machine trigger for button animation
  bool tap = false; // State to track button press state

  @override
  void initState() {
    super.initState();

    // Load the Rive file for Neon3DButton from local assets
    rootBundle.load('packages/enchant_button/assets/CommonButton.riv').then(
      (data) async {
        try {
          // Import Rive file data
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;

          // Get StateMachineController for button animation
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isPressed = controller.findSMI('Pressed'); // Find animation state
          }
          setState(() => riveArtboard = artboard); // Set the artboard state
        } catch (e) {
          throw Exception('Failed to load Neon3DButton assets: $e');
        }
      },
    );
  }

  // Toggle the state of the button animation
  void toggleState(bool newValue) {
    setState(() => isPressed?.value = true);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 100;

    return Container(
      child: riveArtboard == null
          ? const SizedBox()
          : SizedBox(
              height: size,
              width: size,
              child: GestureDetector(
                child: Stack(
                  children: [
                    Rive(
                      artboard: riveArtboard!,
                    ),
                    Positioned(
                      top: size * 0.283, // Adjust the value as needed
                      left: size * 0.277, // Adjust the value as needed
                      child: Center(
                        child: Icon(
                          widget.icon ?? Icons.power_settings_new_rounded,
                          size: size * 0.38,
                          color: tap ? const Color(0xFFFF0083) : Colors.black54,
                          shadows: [
                            tap
                                ? const BoxShadow(
                                    color: Color(0xffff3a9f),
                                    blurRadius: 30,
                                    offset: Offset(0, 0),
                                    spreadRadius: 1)
                                : const BoxShadow(
                                    color: Color(0xffff3a9f),
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTapDown: (details) {
                  tap = !tap;
                  toggleState(tap);
                  widget.onTap?.call();
                },
                onLongPress: () {
                  widget.onLongPress?.call();
                },
                onDoubleTap: () {
                  widget.onDoubleTap?.call();
                },
              ),
            ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------

// AddFavoriteButton Widget
// A dynamic favorite button with a heart animation, adding a touch of whimsy
// to your app's like or favorite functionality.

class AddFavoriteButton extends StatefulWidget {
  // Parameters for AddFavoriteButton Widget
  final double? size; // Size of the button
  final Function? onTap; // Callback function for onTap event
  final Function? onLongPress; // Callback function for onLongPress event

  // Constructor for AddFavoriteButton Widget
  const AddFavoriteButton({
    Key? key,
    this.size,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _AddFavoriteButtonState createState() => _AddFavoriteButtonState();
}

class _AddFavoriteButtonState extends State<AddFavoriteButton> {
  Artboard? riveArtboard; // Artboard for Rive animation
  SMITrigger? isPressed; // State machine trigger for button animation
  bool tap = false; // State to track button press state

  @override
  void initState() {
    super.initState();

    // Load the Rive file for Neon3DButton from local assets
    rootBundle.load('packages/enchant_button/assets/fav_buton_2.riv').then(
      (data) async {
        try {
          // Import Rive file data
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;

          // Get StateMachineController for button animation
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isPressed = controller.findSMI('Like'); // Find animation state
          }
          setState(() => riveArtboard = artboard); // Set the artboard state
        } catch (e) {
          throw Exception();
        }
      },
    );
  }

  // Toggle the state of the button animation
  void toggleState(bool newValue) {
    setState(() => isPressed?.value = !newValue);
  }

  // Build method for AddFavoriteButton Widget
  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 100;
// Container to hold the button
    return Container(
      child: riveArtboard == null
          ? const SizedBox()
          // SizedBox to set button size
          : SizedBox(
              height: size, // Set button height
              width: size, // Set button width
              child: GestureDetector(
                // GestureDetector for button interactions
                child: Rive(
                  artboard: riveArtboard!,
                  antialiasing: true,
                ),
                onTapDown: (details) {
                  // Handle tap event
                  tap = !tap;
                  toggleState(tap);
                  widget.onTap?.call();
                },
                onLongPress: () {
                  // Handle long press event
                  widget.onLongPress?.call();
                },
              ),
            ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------

// RadioButtonBounce Widget
// A stylish radio button with a flash animation effect, ideal for selecting
// options in forms and surveys.

class RadioButtonBounce extends StatefulWidget {
  // Parameters for RadioButtonBounce Widget
  final double? size; // Size of the button
  final Function? onTap; // Callback function for onTap event
  final Function? onLongPress; // Callback function for onLongPress event

  // Constructor for RadioButtonBounce Widget
  const RadioButtonBounce({
    super.key,
    this.size,
    this.onTap,
    this.onLongPress,
  });

  @override
  _RadioButtonBounceState createState() => _RadioButtonBounceState();
}

class _RadioButtonBounceState extends State<RadioButtonBounce> {
  Artboard? riveArtboard; // Artboard for Rive animation
  SMITrigger? isPressed; // State machine trigger for button animation
  bool tap = false; // State to track button press state

  @override
  void initState() {
    super.initState();

    // Load the Rive file for Neon3DButton from local assets
    rootBundle.load('packages/enchant_button/assets/radio_button.riv').then(
      (data) async {
        try {
          // Import Rive file data
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;

          // Get StateMachineController for button animation
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isPressed = controller.findSMI('Pressed'); // Find animation state
          }
          setState(() => riveArtboard = artboard);
        } catch (e) {
          throw Exception();
        }
      },
    );
  }

  // Toggle the state of the button animation
  void toggleState(bool newValue) {
    setState(() => isPressed?.value = newValue);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 30;

    return Container(
      child: riveArtboard == null
          ? const SizedBox()
          : SizedBox(
              height: size,
              width: size,
              child: GestureDetector(
                child: Rive(
                  artboard: riveArtboard!,
                  antialiasing: true,
                ),
                onTapDown: (details) {
                  tap = !tap;
                  toggleState(tap);
                  widget.onTap?.call();
                },
                onLongPress: () {
                  widget.onLongPress?.call();
                },
              ),
            ),
    );
  }
}
