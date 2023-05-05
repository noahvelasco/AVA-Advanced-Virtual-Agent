import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../widgets/credits_screen/export_credits_widgets.dart';

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({super.key});

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen>
    with SingleTickerProviderStateMixin {
  //This controller is used to make the background gradient animate
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
      duration: const Duration(
          seconds:
              3), //controlls how long the animation will take in its entirety
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller
        .dispose(); // dispose the controller so there is no error with the ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: AnimateGradient(
        controller: _controller,
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.topRight,
        secondaryBegin: Alignment.bottomCenter,
        secondaryEnd: Alignment.bottomLeft,
        primaryColors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
        secondaryColors: [
          colorScheme.secondary,
          colorScheme.primary,
        ],
        //The sized box allows the background animated gradient to take over the entire screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            AboutDialoguePopUp(),
          ],
        ),
      ),
    );
  }
}
