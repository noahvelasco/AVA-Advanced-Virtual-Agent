import 'package:flutter/material.dart';

import '../controllers/input_ellabs_key_controller.dart';
import '../widgets/home_screen/export_home_screen_widgets.dart';
import '../controllers/input_question_controller.dart';
import '../controllers/input_gpt_key_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final InputQuestionController inputTextEditingController =
      InputQuestionController();

  final InputGPTKeyController inputGPTKeyController = InputGPTKeyController();

  final InputElLabsKeyController inputElLabsKeyController =
      InputElLabsKeyController();

  @override
  void initState() {
    super.initState();

    //set the initial text for the controllers here
    inputTextEditingController.setText("");
    inputGPTKeyController.setText("");
    inputElLabsKeyController.setText("");
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed
    inputTextEditingController.dispose();
    inputGPTKeyController.dispose();
    inputElLabsKeyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: null,
      body: Container(
        color: colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                OutputBox(),
                SizedBox(height: 15),
                OutputTTSButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InputBox(controller: inputTextEditingController),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        const InputPromptButton(),
                        const SizedBox(width: 15),
                        InputClearButton(
                          controller: inputTextEditingController,
                        ),
                        const SizedBox(width: 15),
                        InputSubmitButton(
                          controller: inputTextEditingController,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const CreditsButton(),
                const ThemeModeButton(),
                SettingsButton(
                  inputGPTKeyController: inputGPTKeyController,
                  inputElLabsKeyController: inputElLabsKeyController,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
