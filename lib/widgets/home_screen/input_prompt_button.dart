// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../providers/theme_provider.dart';

class InputPromptButton extends StatefulWidget {
  const InputPromptButton({super.key});

  @override
  State<InputPromptButton> createState() => _InputPromptButtonState();
}

class _InputPromptButtonState extends State<InputPromptButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.height * 0.05,
      child: NeumorphicButton(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
        minDistance: -5,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          debugPrint("TODO - Gives some prompts");
        },
        style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          intensity: provider.theme == ThemeMode.light ? .8 : .6,
          color: colorScheme.primary,
          shadowLightColor: Colors.white,
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: Colors.white,
          shadowDarkColorEmboss: Colors.black,
          depth: 2,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        ),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.lightbulb,
            size: 16,
          ),
        ),
      ),
    );
  }
}
