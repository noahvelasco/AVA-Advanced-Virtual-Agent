import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AboutDialoguePopUp extends StatefulWidget {
  const AboutDialoguePopUp({super.key});

  @override
  State<AboutDialoguePopUp> createState() => _AboutDialoguePopUpState();
}

class _AboutDialoguePopUpState extends State<AboutDialoguePopUp> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textThemeItalicized = textTheme.bodyMedium!.copyWith(
      fontStyle: FontStyle.italic,
    );

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: AboutDialog(
        applicationName: "A.V.A.\nAdvanced Virtual Agent",
        applicationVersion: "2.0",
        applicationIcon: Image.asset(
          'assets/images/icon.png',
          width: width * .15,
          color: colorScheme.secondary,
        ),
        applicationLegalese:
            "Copyright © 2023 Noah Velasco.\nAll rights reserved.",
        children: <Widget>[
          Divider(
            height: height * .05,
            color: colorScheme.secondary,
          ),
          Text(
            "• Flutter Version: 3.7.12",
            style: textTheme.bodyMedium,
          ),
          Text(
            "• Dart SDK Version: 2.19.6",
            style: textTheme.bodyMedium,
          ),
          Divider(
            height: height * .05,
            color: colorScheme.secondary,
          ),
          Text(
            "Inspired by Ava and Samantha",
            style: textThemeItalicized,
          ),
        ],
      ),
    );
  }
}
