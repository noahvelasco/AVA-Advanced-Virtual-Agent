import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../views/credits_screen.dart';

class CreditsButton extends StatefulWidget {
  const CreditsButton({super.key});

  @override
  State<CreditsButton> createState() => _CreditsButtonState();
}

class _CreditsButtonState extends State<CreditsButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return NeumorphicButton(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      minDistance: -5,
      style: NeumorphicStyle(
        lightSource: LightSource.topLeft,
        intensity: provider.theme == ThemeMode.light ? .8 : .4,
        color: colorScheme.primary,
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.black,
        shadowLightColorEmboss: Colors.white,
        shadowDarkColorEmboss: Colors.black,
        depth: provider.theme == ThemeMode.light ? 9 : 3,
        shape: NeumorphicShape.concave,
        surfaceIntensity: .5,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();

        //navigate to credits screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const CreditsScreen(),
          ),
        );
      },
      child: const FaIcon(
        FontAwesomeIcons.info,
      ),
    );
  }
}
