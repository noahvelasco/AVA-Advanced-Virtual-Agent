import 'package:ava_v2/providers/export_providers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OutputBox extends StatefulWidget {
  const OutputBox({super.key});

  @override
  State<OutputBox> createState() => _OutputBoxState();
}

class _OutputBoxState extends State<OutputBox> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLoadingProvider = Provider.of<LoadingIconGPTProvider>(context);
    final ChatHistoryProvider chatHistoryProvider =
        Provider.of<ChatHistoryProvider>(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    ScrollController outputScrollController = ScrollController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: width * 0.75,
          height: height * 0.2,
          child: NeumorphicButton(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            minDistance: -5,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Clipboard.setData(
                ClipboardData(
                  text: chatHistoryProvider.chatHistory.last["content"]!,
                ),
              );
              final snackBar = SnackBar(
                dismissDirection: DismissDirection.vertical,
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: height * 0.90),
                behavior: SnackBarBehavior.floating,
                content: Center(
                  child: Text(
                    'Copied to clipboard!',
                    style: textTheme.bodyMedium,
                  ),
                ),
                backgroundColor: Colors.grey,
                shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  1,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            style: NeumorphicStyle(
              lightSource: LightSource.topLeft,
              intensity: themeProvider.theme == ThemeMode.light ? .8 : .6,
              color: colorScheme.primary,
              shadowLightColor: Colors.white,
              shadowDarkColor: Colors.black,
              shadowLightColorEmboss: Colors.white,
              shadowDarkColorEmboss: Colors.black,
              depth: themeProvider.theme == ThemeMode.light ? 9 : 3,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            ),
            child: isLoadingProvider.isLoading
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        colorScheme.secondary, BlendMode.srcIn),
                    child: Center(
                      child: Lottie.asset('assets/lottie/polygonal_star.json'),
                    ),
                  )
                : RawScrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 2.0,
                    thumbColor: colorScheme.secondary,
                    trackColor: colorScheme.primary,
                    interactive: true,
                    controller: outputScrollController,
                    child: SingleChildScrollView(
                      controller: outputScrollController,
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: SizedBox(
                          width: width,
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText(
                                chatHistoryProvider
                                    .chatHistory.last["content"]!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
