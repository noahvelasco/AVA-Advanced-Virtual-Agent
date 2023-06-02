import 'package:flutter/material.dart';

import '../database/api_key_storage_helper.dart';
import '../database/prompt_storage_helper.dart';
import '../widgets/home_screen/export_home_screen_widgets.dart';
import '../controllers/input_question_controller.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final APIKeyStorageHelper apiKeyStorageHelper;
  final PromptStorageHelper promptStorageHelper;

  const Home(
      {super.key,
      required this.apiKeyStorageHelper,
      required this.promptStorageHelper});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late InputQuestionController inputQuestionEditingController;

  @override
  void initState() {
    super.initState();

    //set the initial text for the controllers here
    inputQuestionEditingController = InputQuestionController();
    inputQuestionEditingController.setText("");

    //TODO delete below since they were for testing only
    printDatabaseContents();
    widget.promptStorageHelper.deleteAllData();
    debugPrint("after deleting");
    printDatabaseContents();
  }

  //TODO relocate function since it was only for testing
  Future<void> printDatabaseContents() async {
    final List<Map<String, dynamic>> data =
        await widget.promptStorageHelper.getAllData();
    data.forEach((row) {
      final title = row['title'];
      final prompt = row['prompt'];
      print('Title: $title, Prompt: $prompt');
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed
    inputQuestionEditingController.dispose();
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
              children: <Widget>[
                const OutputBox(),
                const SizedBox(height: 15),
                OutputTTSButton(
                  apiKeyStorageHelper: widget.apiKeyStorageHelper,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InputBox(controller: inputQuestionEditingController),
                    const SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        //todo - pass the database into here
                        InputPromptButton(
                            inputQuestionController:
                                inputQuestionEditingController,
                            promptStorageHelper: widget.promptStorageHelper),
                        const SizedBox(width: 15),
                        InputClearButton(
                          controller: inputQuestionEditingController,
                        ),
                        const SizedBox(width: 15),
                        InputSubmitButton(
                          apiKeyStorageHelper: widget.apiKeyStorageHelper,
                          controller: inputQuestionEditingController,
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
                  apiKeyStorageHelper: widget.apiKeyStorageHelper,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
