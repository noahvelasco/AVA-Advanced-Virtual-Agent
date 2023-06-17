import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/input_question_controller.dart';

import '../../providers/theme_provider.dart';

class InputClearButton extends StatefulWidget {
//Text editing controller is being passed into here and will be 'controller'
  final InputQuestionController controller;
  const InputClearButton({super.key, required this.controller});
  @override
  State<InputClearButton> createState() => _InputClearButtonState();
}

class _InputClearButtonState extends State<InputClearButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.22,
      height: height * 0.05,
      child: NeumorphicButton(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
        minDistance: -5,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.controller.inputQuestionTextEditingController.clear();
        },
        style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          intensity: provider.theme == ThemeMode.light ? .8 : .6,
          color: colorScheme.primary,
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: Colors.white,
          shadowDarkColorEmboss: Colors.black,
          depth: 2,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        ),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.x,
            size: 16,
          ),
        ),
      ),
    );
  }
}
