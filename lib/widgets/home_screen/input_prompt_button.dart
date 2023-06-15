// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/input_question_controller.dart';
import '../../providers/theme_provider.dart';
import '../bottom_sheets/prompt_bottom_sheet.dart';

class InputPromptButton extends StatefulWidget {
  final InputQuestionController inputQuestionController;
  final List<Map>? promptList;

  const InputPromptButton({
    super.key,
    required this.inputQuestionController,
    required this.promptList,
  });

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
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();

          showModalBottomSheet(
              context: context,
              backgroundColor: colorScheme.primary,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: colorScheme.secondary, strokeAlign: 5, width: 5),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(0),
                ),
              ),
              builder: (BuildContext context) {
                return PromptBottomSheet(
                  inputQuestionController: widget.inputQuestionController,
                  promptList: widget.promptList,
                );
              });
        },
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
