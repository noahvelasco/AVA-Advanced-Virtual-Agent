import 'package:ava_v2/providers/export_providers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../database/api_key_storage_helper.dart';

class SettingsBottomSheet extends StatefulWidget {
  final APIKeyStorageHelper apiKeyStorageHelper;
  const SettingsBottomSheet({super.key, required this.apiKeyStorageHelper});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  late TextEditingController inputGPTKeyController = TextEditingController();
  late TextEditingController inputElLabsKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  @override
  void dispose() {
    inputGPTKeyController.dispose();
    inputElLabsKeyController.dispose();
    super.dispose();
  }

  void initializeControllers() async {
    inputGPTKeyController.text =
        (await widget.apiKeyStorageHelper.getGPTAPIKey()) ?? "";
    inputElLabsKeyController.text =
        (await widget.apiKeyStorageHelper.getELAPIKey()) ?? "";
  }

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
                          controller: inputGPTKeyController,
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
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel_sharp),
                              onPressed: () {
                                widget.apiKeyStorageHelper.deleteGPTAPIKey();
                                inputGPTKeyController.clear();
                              },
                            ),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            widget.apiKeyStorageHelper
                                .saveGPTAPIKey(inputGPTKeyController.text);

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
                            FontAwesomeIcons.check,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          widget.apiKeyStorageHelper
                              .saveGPTAPIKey(inputGPTKeyController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
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
                          controller: inputElLabsKeyController,
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
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel_sharp),
                              onPressed: () {
                                widget.apiKeyStorageHelper.deleteELAPIKey();
                                inputElLabsKeyController.clear();
                              },
                            ),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            widget.apiKeyStorageHelper
                                .saveELAPIKey(inputElLabsKeyController.text);
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
                            FontAwesomeIcons.check,
                            size: 15,
                          ),
                        ),
                        onPressed: () {
                          widget.apiKeyStorageHelper
                              .saveELAPIKey(inputElLabsKeyController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
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
                "GPT Temperature",
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
