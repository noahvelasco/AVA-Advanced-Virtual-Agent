import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/api_key_storage_helper.dart';
import '../widgets/home_screen/export_home_screen_widgets.dart';
import '../controllers/input_question_controller.dart';

class Home extends StatefulWidget {
  final APIKeyStorageHelper apiKeyStorageHelper;
  final List<Map>? promptList;

  const Home({
    super.key,
    required this.apiKeyStorageHelper,
    required this.promptList,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late InputQuestionController inputQuestionEditingController;

  @override
  void initState() {
    super.initState();
    playWelcomeMessage();

    //set the initial text for the controllers here
    inputQuestionEditingController = InputQuestionController();
    inputQuestionEditingController.setText("");
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed
    inputQuestionEditingController.dispose();
    super.dispose();
  }

  void playWelcomeMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasBeenPlayed = prefs.getBool('welcomeMessagePlayed') ?? false;
    debugPrint("hasBeenPlayed is $hasBeenPlayed");

    //if the welcome message hasnt been played then play it
    if (hasBeenPlayed == false) {
      AudioPlayer audioPlayer = AudioPlayer();

      try {
        await audioPlayer.setAsset('../../assets/audio/WelcomeMessage.mp3');
        await audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing audio: $e');
      } finally {
        audioPlayer.dispose();
      }

      // Set the flag to indicate it has been played
      await prefs.setBool('welcomeMessagePlayed', true);
    }
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
                        InputPromptButton(
                          inputQuestionController:
                              inputQuestionEditingController,
                          promptList: widget.promptList,
                        ),
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
