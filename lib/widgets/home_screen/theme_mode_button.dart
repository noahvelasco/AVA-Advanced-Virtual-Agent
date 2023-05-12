import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ThemeModeButton extends StatefulWidget {
  const ThemeModeButton({super.key});

  @override
  State<ThemeModeButton> createState() => _ThemeModeButtonState();
}

class _ThemeModeButtonState extends State<ThemeModeButton> {
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
        provider.toggleTheme();
      },
      child: Icon(
        provider.theme == ThemeMode.light ? Icons.mode_night : Icons.sunny,
        size: 30,
      ),
    );
  }
}
