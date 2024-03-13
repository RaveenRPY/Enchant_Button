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
  final bool? isHoldable; // state of the button is holdable type
  final int? popOutDelay; // the value of the holdable button pop out delay
  final Function? onTap; // Callback function for onTap event
  final Function? onLongPress; // Callback function for onLongPress event
  final Function? onDoubleTap; // Callback function for onDoubleTap event

  // Constructor for Neon3DButton Widget
  const Neon3DButton({super.key,
    this.icon,
    this.size,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.isHoldable = true,
    this.popOutDelay = 500,});

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
          riveArtboard = artboard; // Set the artboard state
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
          onTapDown: (details) async {
            tap = !tap;
            toggleDance(tap);
            if (!widget.isHoldable!) {
              await Future.delayed(const Duration(milliseconds: 500));
              tap = !tap;
              toggleDance(tap);
            }
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
  final bool? isPressed; // Initial state of the button

  // Constructor for AddFavoriteButton Widget
  const AddFavoriteButton({
    Key? key,
    this.size,
    this.onTap,
    this.onLongPress,
    this.isPressed = false,
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
          riveArtboard = artboard; // Set the artboard state

          if (widget.isPressed!) {
            toggleState(true);
            tap = !tap;
          }
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

//-------------------------------------------------------------------------------------------------------

// FalingSwitch Widget
// A stylish Switch with a faling animation effect, ideal for selecting
// options in forms and surveys.

/// A customizable falling switch widget with Rive animation.
class FalingSwitch extends StatefulWidget {
  // Parameters for the FalingSwitch widget
  final double? size; // Size of the switch widget
  final Function? onTap; // Callback function for onTap event
  final bool? isPressed; // Initial state of the switch (pressed or not)

  /// Constructor for the FalingSwitch widget
  const FalingSwitch({
    Key? key,
    this.size,
    this.onTap,
    this.isPressed = false, // Default value for isPressed parameter
  }) : super(key: key);

  @override
  _RadioButtonFlashState createState() => _RadioButtonFlashState();
}

class _RadioButtonFlashState extends State<FalingSwitch> {
  Artboard? riveArtboard; // Artboard for Rive animation
  SMIBool? isPressed; // State machine trigger for switch animation
  bool tap = false; // State to track switch state

  @override
  void initState() {
    super.initState();
    // Load the Rive file for FalingSwitch from local assets
    rootBundle.load('packages/enchant_button/assets/anime_switch.riv').then(
          (data) async {
        try {
          // Import Rive file data
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          // Get StateMachineController for switch animation
          var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isPressed = controller.findSMI('Boolean 1'); // Find animation state
          }
          setState(() => riveArtboard = artboard); // Set the artboard state
          // If the switch is initially pressed, toggle the state
          if (widget.isPressed!) {
            toggleState(true);
            tap = !tap;
          }
        } catch (e) {
          print(e); // Handle any errors during initialization
        }
      },
    );
  }

  // Toggle the state of the switch animation
  void toggleState(bool newValue) {
    setState(() => isPressed?.value = newValue);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 70;

    return Container(
      child: riveArtboard == null
          ? const SizedBox()
      // SizedBox to set switch size
          : SizedBox(
        height: size, // Set switch height
        width: size, // Set switch width
        child: GestureDetector(
          // GestureDetector for switch interactions
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
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------

// NeonSwitch Widget
// A switch button with a neon effect animation, perfect for toggling settings or switching between states in your app.

class NeonSwitch extends StatefulWidget {
  // Parameters for NeonSwitch Widget
  final double? size; // Size of the button
  final Function? onTap; // Callback function for onTap event

  // Constructor for NeonSwitch Widget
  const NeonSwitch({
    Key? key,
    this.size,
    this.onTap,
  }) : super(key: key);

  @override
  _NeonSwitchState createState() => _NeonSwitchState();
}

class _NeonSwitchState extends State<NeonSwitch> {
  // Properties for Rive animation
  Artboard? riveArtboard; // Artboard for Rive animation
  SMITrigger? isPressed; // State machine trigger for button animation
  bool tap = false; // State to track button press state

  @override
  void initState() {
    super.initState();
    // Load the Rive file for NeonSwitch from local assets
    rootBundle.load('packages/enchant_button/assets/neon_switch.riv').then(
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
            isPressed = controller.findSMI('Hit'); // Find animation state
          }
          setState(() => riveArtboard = artboard); // Set the artboard state
        } catch (e) {
          print(e);
        }
      },
    );
  }

  // Toggle the state of the button animation
  void toggleState(bool newValue) {
    setState(() => isPressed?.value = true);
  }

  // Build method for NeonSwitch Widget
  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 100;

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
          onTap: () {
            // Handle tap event
            tap = !tap;
            toggleState(tap);
            widget.onTap?.call();
          },
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------------

// StartButton3D Widget
//
// A 3D start button with animated clicking and hovering effects, suitable for starting an action in your app.

class StartButton3D extends StatefulWidget {
  // Parameters for StartButton3D Widget
  final double? size; // Size of the button
  final Function? onTap; // Callback function for onTap event
  final Function? onLongPress; // Callback function for onLongPress event

  // Constructor for StartButton3D Widget
  const StartButton3D({
    Key? key,
    this.size,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _StartButton3DState createState() => _StartButton3DState();
}

class _StartButton3DState extends State<StartButton3D> {
  // Properties for Rive animation
  Artboard? riveArtboard; // Artboard for Rive animation
  SMIBool? isPressed; // State machine trigger for clicked animation
  SMIBool? isHover; // State machine trigger for hovering animation
  bool tap = false; // State to track button press state

  @override
  void initState() {
    super.initState();
    // Load the Rive file for StartButton3D from local assets
    rootBundle.load('packages/enchant_button/assets/start_button.riv').then(
          (data) async {
        try {
          // Import Rive file data
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          // Get StateMachineController for button animations
          var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isPressed = controller.findSMI('Clicked'); // Find clicked animation state
            isHover = controller.findSMI('Hovering'); // Find hovering animation state
          }
          riveArtboard = artboard; // Set the artboard state
          isHover?.value = true; // Set initial hovering animation state
        } catch (e) {
          print(e);
        }
      },
    );
  }

  // Method to trigger the clicked animation
  Future<void> toggleState() async {
    isPressed?.value = true; // Set clicked animation state to true
    await Future.delayed(const Duration(milliseconds: 100)); // Delay for animation effect
    isPressed?.value = false; // Reset clicked animation state
  }

  // Build method for StartButton3D Widget
  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 250; // Set default button size

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
          onTap: () {
            // Handle tap event
            tap = !tap;
            toggleState();
            widget.onTap?.call();
          },
        ),
      ),
    );
  }
}



