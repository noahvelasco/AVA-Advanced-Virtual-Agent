// ignore: unnecessary_import
import 'package:ava_v2/providers/export_providers.dart';
import '../../view_models/gpt_api_view_model.dart';
import '../../controllers/input_question_controller.dart';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class InputBox extends StatefulWidget {
  //Text editing controller is being passed into here and will be 'controller'
  final InputQuestionController controller;
  // ignore: use_key_in_widget_constructors
  const InputBox({required this.controller});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  GPTAPIViewModel gptAPIViewModel = GPTAPIViewModel();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // gptAPIViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ScrollController inputScrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: width * 0.75,
          height: height * 0.2,
          child: Neumorphic(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            style: NeumorphicStyle(
              lightSource: LightSource.topLeft,
              intensity: provider.theme == ThemeMode.light ? .8 : .6,
              color: colorScheme.primary,
              shadowLightColor: Colors.white,
              shadowDarkColor: Colors.black,
              shadowLightColorEmboss: Colors.white,
              shadowDarkColorEmboss: Colors.black,
              depth: provider.theme == ThemeMode.light ? 9 : 3,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            ),
            child: RawScrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 2.0,
              thumbColor: colorScheme.secondary,
              trackColor: colorScheme.primary,
              interactive: true,
              controller: inputScrollController,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 10),
                controller: inputScrollController,
                scrollDirection: Axis.vertical,
                child: TextField(
                  controller:
                      widget.controller.inputQuestionTextEditingController,

                  cursorColor: provider.theme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  maxLines: null,
                  maxLength: 150, //max chars for the box
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: colorScheme.secondary.withOpacity(.3),
                        fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    hintText: 'Who was socrates?',
                  ),
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
