import 'package:ava_v2/controllers/export_controllers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../providers/theme_provider.dart';

// ignore: must_be_immutable
class PromptBottomSheet extends StatelessWidget {
  InputQuestionController inputQuestionController;
  // ignore: use_key_in_widget_constructors
  PromptBottomSheet({required this.inputQuestionController});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final provider = Provider.of<ThemeProvider>(context);

    final List<Widget> customWidgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          minDistance: -5,
          style: NeumorphicStyle(
            lightSource: LightSource.topLeft,
            intensity: provider.theme == ThemeMode.light ? .8 : .6,
            color: colorScheme.primary,
            shadowDarkColor: Colors.black,
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.black,
            depth: 2,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.message,
              size: 40,
            ),
          ),
          onPressed: () {
            inputQuestionController.setText(
                'Write me a message responding to [message] \n\nmessage: ');
            Navigator.pop(context);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          minDistance: -5,
          style: NeumorphicStyle(
            lightSource: LightSource.topLeft,
            intensity: provider.theme == ThemeMode.light ? .8 : .6,
            color: colorScheme.primary,
            shadowDarkColor: Colors.black,
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.black,
            depth: 2,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.dollarSign,
              size: 40,
            ),
          ),
          onPressed: () {
            inputQuestionController
                .setText('How can I make money with [topic]\n\ntopic: ');
            Navigator.pop(context);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          minDistance: -5,
          style: NeumorphicStyle(
            lightSource: LightSource.topLeft,
            intensity: provider.theme == ThemeMode.light ? .8 : .6,
            color: colorScheme.primary,
            shadowDarkColor: Colors.black,
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.black,
            depth: 2,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.language,
              size: 40,
            ),
          ),
          onPressed: () {
            inputQuestionController.setText(
                'Translate [text] to [language]\n\ntext: \nlanguage: ');
            Navigator.pop(context);
          },
        ),
      ),
    ];

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          CarouselSlider(
            items: customWidgets,
            options: CarouselOptions(
              height: 100,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: .3,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ]),
      );
    });
  }
}
