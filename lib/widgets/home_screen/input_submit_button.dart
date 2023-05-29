// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/input_question_controller.dart';

import '../../database/api_key_storage_helper.dart';
import '../../providers/theme_provider.dart';
import '../../view_models/gpt_api_view_model.dart';

class InputSubmitButton extends StatefulWidget {
  //Is being passed down from home and will be sent to "fetchGPTResponse()"
  final APIKeyStorageHelper apiKeyStorageHelper;

  //Text editing controller is being passed into here and will be 'controller'
  final InputQuestionController controller;

  // ignore: use_key_in_widget_constructors
  const InputSubmitButton({
    required this.apiKeyStorageHelper,
    required this.controller,
  });

  @override
  State<InputSubmitButton> createState() => _InputSubmitButtonState();
}

class _InputSubmitButtonState extends State<InputSubmitButton> {
  GPTAPIViewModel gptAPIViewModel = GPTAPIViewModel();

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
          gptAPIViewModel.fetchGPTResponse(context, widget.apiKeyStorageHelper,
              widget.controller.inputQuestionTextEditingController.text);
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
            FontAwesomeIcons.paperPlane,
            size: 16,
          ),
        ),
      ),
    );
  }
}
