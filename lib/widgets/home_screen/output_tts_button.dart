// ignore: unnecessary_import
import 'package:ava_v2/providers/export_providers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../database/api_key_storage_helper.dart';
import '../../view_models/export_view_models.dart';

class OutputTTSButton extends StatefulWidget {
  //Is being passed down from home and will be sent to "fetchGPTResponse()"
  final APIKeyStorageHelper apiKeyStorageHelper;

  OutputTTSButton({required this.apiKeyStorageHelper});

  @override
  State<OutputTTSButton> createState() => _OutputTTSButtonState();
}

class _OutputTTSButtonState extends State<OutputTTSButton> {
  ELAPIViewModel gptAPIViewModel = ELAPIViewModel();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final isLoadingVoiceProvider = Provider.of<LoadingIconELProvider>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.75,
      height: height * 0.05,
      child: NeumorphicButton(
        padding: EdgeInsets.all(width * 0.025),
        minDistance: -5,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          gptAPIViewModel.playTextToSpeech(
            context,
            widget.apiKeyStorageHelper,
          );
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
        child: Center(
          child: isLoadingVoiceProvider.isLoading
              ? LinearProgressIndicator(
                  color: colorScheme.secondary,
                  backgroundColor: colorScheme.primary,
                  minHeight: 2,
                )
              : const Icon(Icons.volume_up_outlined, size: 25),
        ),
      ),
    );
  }
}
