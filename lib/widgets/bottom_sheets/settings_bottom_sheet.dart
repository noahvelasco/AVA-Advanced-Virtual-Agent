import 'package:ava_v2/controllers/export_controllers.dart';
import 'package:ava_v2/providers/export_providers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsBottomSheet extends StatelessWidget {
  InputGPTKeyController inputGPTKeyController;
  InputElLabsKeyController inputElLabsKeyController;

  // ignore: use_key_in_widget_constructors
  SettingsBottomSheet(
      {required this.inputGPTKeyController,
      required this.inputElLabsKeyController});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //All setting presets: api keys, and slider values
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final provider = Provider.of<ThemeProvider>(context);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: height * .025, bottom: height * .025),
                child: SizedBox(
                  width: width * .9,
                  child: Image.asset(
                    'assets/images/logo-no-background.png',
                    fit: BoxFit.cover,
                    color: colorScheme.secondary,
                  ),
                ),
              ),
              const Text("GPT-3.5-Turbo API Key"),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * .75,
                      height: height * .05,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity: .8,
                          color: colorScheme.primary,
                          shadowDarkColor: Colors.black,
                          depth: 3,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(40)),
                          oppositeShadowLightSource: false,
                        ),
                        child: TextField(
                          controller: inputGPTKeyController
                              .inputGPTKeyTextEditingController,
                          cursorColor: colorScheme.secondary,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 16),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: colorScheme.primary,
                            hintText: "sk-5yg2...",
                            hintStyle: textTheme.bodyMedium!.copyWith(
                                color: colorScheme.secondary.withOpacity(.5),
                                fontStyle: FontStyle.italic),
                            suffixIcon: const Icon(Icons.create),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            //autosave the anytext removed or added from this textfield
                            inputGPTKeyController.setText(inputGPTKeyController
                                .inputGPTKeyTextEditingController.text);

                            //then save the key into the settings provider - this will update the settings fields
                            settingsProvider.setGPTAPIKey(inputGPTKeyController
                                .inputGPTKeyTextEditingController.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      height: height * 0.05,
                      child: NeumorphicButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        minDistance: -5,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity:
                              provider.theme == ThemeMode.light ? .8 : .6,
                          color: colorScheme.primary,
                          shadowDarkColor: Colors.black,
                          shadowLightColorEmboss: Colors.white,
                          shadowDarkColorEmboss: Colors.black,
                          depth: 2,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.trashCan,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          //autosave the update
                          FocusManager.instance.primaryFocus?.unfocus();
                          inputGPTKeyController.inputGPTKeyTextEditingController
                              .clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text("ElevenLabs API Key"),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * .75,
                      height: height * .05,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity: .8,
                          color: colorScheme.primary,
                          shadowDarkColor: Colors.black,
                          depth: 3,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(40)),
                          oppositeShadowLightSource: false,
                        ),
                        child: TextField(
                          controller: inputElLabsKeyController
                              .inputElLabsKeyTextEditingController,
                          cursorColor: colorScheme.secondary,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 16),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: colorScheme.primary,
                            hintText: "23232...",
                            hintStyle: textTheme.bodyMedium!.copyWith(
                                color: colorScheme.secondary.withOpacity(.5),
                                fontStyle: FontStyle.italic),
                            suffixIcon: const Icon(Icons.create),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            //autosave the anytext removed or added from this textfield
                            inputElLabsKeyController.setText(
                                inputElLabsKeyController
                                    .inputElLabsKeyTextEditingController.text);

                            //then save the key into the settings provider - this will update the settings fields
                            settingsProvider.setElLabsAPIKey(
                                inputElLabsKeyController
                                    .inputElLabsKeyTextEditingController.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      height: height * 0.05,
                      child: NeumorphicButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        minDistance: -5,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity:
                              provider.theme == ThemeMode.light ? .8 : .6,
                          color: colorScheme.primary,
                          shadowDarkColor: Colors.black,
                          shadowLightColorEmboss: Colors.white,
                          shadowDarkColorEmboss: Colors.black,
                          depth: 2,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.trashCan,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          inputElLabsKeyController
                              .inputElLabsKeyTextEditingController
                              .clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: colorScheme.secondary,
                thickness: 2,
                indent: width * .2,
                endIndent: width * .2,
                height: height * .075,
              ),
              Text(
                "Creativity",
                style: textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(settingsProvider.gptTemp.toString(),
                      style: textTheme.bodyMedium),
                  SizedBox(
                    width: width * .8,
                    height: height * .05,
                    child: NeumorphicSlider(
                      style: SliderStyle(
                        accent: colorScheme.primary,
                        variant: colorScheme.secondary,
                        disableDepth: true,
                        border: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.primary,
                          width: width * .025,
                        ),
                        thumbBorder: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.secondary,
                          width: width * .006,
                        ),
                      ),
                      value: settingsProvider.gptTemp,
                      min: 0.0,
                      max: 1.0,
                      sliderHeight: 1,
                      onChanged: (double value) {
                        settingsProvider
                            .setGPTTemp(double.parse(value.toStringAsFixed(2)));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .03),
              Text(
                "Voice Stability",
                style: textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(settingsProvider.elLabsExpr.toString(),
                      style: textTheme.bodyMedium),
                  SizedBox(
                    width: width * .8,
                    height: height * .05,
                    child: NeumorphicSlider(
                      style: SliderStyle(
                        accent: colorScheme.primary,
                        variant: colorScheme.secondary,
                        disableDepth: true,
                        border: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.primary,
                          width: width * .025,
                        ),
                        thumbBorder: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.secondary,
                          width: width * .006,
                        ),
                      ),
                      value: settingsProvider.elLabsExpr,
                      min: 0.0,
                      max: 1.0,
                      sliderHeight: 1,
                      onChanged: (double value) {
                        settingsProvider.setElLabsExpr(
                            double.parse(value.toStringAsFixed(2)));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .03),
              Text(
                "Voice Clarity + Similarity Enhancement",
                style: textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(settingsProvider.elLabsClar.toString(),
                      style: textTheme.bodyMedium),
                  SizedBox(
                    width: width * .8,
                    height: height * .05,
                    child: NeumorphicSlider(
                      style: SliderStyle(
                        accent: colorScheme.primary,
                        variant: colorScheme.secondary,
                        disableDepth: true,
                        border: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.primary,
                          width: width * .025,
                        ),
                        thumbBorder: NeumorphicBorder(
                          isEnabled: true,
                          color: colorScheme.secondary,
                          width: width * .006,
                        ),
                      ),
                      value: settingsProvider.elLabsClar,
                      min: 0.0,
                      max: 1.0,
                      sliderHeight: 1,
                      onChanged: (double value) {
                        settingsProvider.setElLabsClar(
                            double.parse(value.toStringAsFixed(2)));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
            ],
          ),
        );
      },
    );
  }
}
