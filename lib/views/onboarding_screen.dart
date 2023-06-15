import 'package:ava_v2/providers/export_providers.dart';
import 'package:ava_v2/views/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/api_key_storage_helper.dart';

class OnBoardingPage extends StatefulWidget {
  //APIKeyStorageHelper below is being given from the main.dart.
  final APIKeyStorageHelper apiKeyStorageHelper;
  final promptList;

  const OnBoardingPage({
    super.key,
    required this.apiKeyStorageHelper,
    required this.promptList,
  });

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late TextEditingController inputGPTKeyController = TextEditingController();
  late TextEditingController inputElLabsKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputGPTKeyController.dispose();
    inputElLabsKeyController.dispose();
    super.dispose();
  }

  TextStyle titleStyle = GoogleFonts.montserrat(
    color: const Color(0xFFE7ECEF),
    fontSize: 24.0,
  );

  TextStyle bodyStyle = GoogleFonts.montserrat(
    color: const Color(0xFFE7ECEF),
    fontSize: 16.0,
  );

  void _onIntroEnd(context) {
    //Pass the value of the API Keys to the Home Screen if they are valid
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Home(
          //pass the same secure storage object down to home now so we can print this in the settings section
          apiKeyStorageHelper: widget.apiKeyStorageHelper,
          promptList: widget.promptList,
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String assetName, double width) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  Widget _buildLottieImage(String assetName, bool rep, [double height = 350]) {
    return Center(
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
        child: Lottie.asset(
          'assets/lottie/$assetName',
          height: height,
          repeat: rep,
        ),
      ),
    );
  }

  Future<void> _launchGPTUrl() async {
    Uri url = Uri.parse("https://platform.openai.com/account/api-keys");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchELUrl() async {
    Uri url =
        Uri.parse("https://docs.elevenlabs.io/authentication/01-xi-api-key");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    final provider = Provider.of<ThemeProvider>(context);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      titlePadding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 10.0),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 00.0, 16.0, 0.0),
      imagePadding: const EdgeInsets.only(
        top: 120,
      ),
      pageColor: const Color(0xFF252525),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color(0xFF252525),
      allowImplicitScrolling: true,
      globalHeader: Align(
        alignment: Alignment.topLeft,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: _buildHeaderImage(
                'splash.png', 100), //replace this with a new logo if any
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Let's get you set up!",
          image: _buildLottieImage('polygonal_star.json', true, 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "GPT API Key Setup",
          body: "Enter your OpenAI GPT-3.5-Turbo Key",
          image: _buildLottieImage('outlined_circle.json', true, 500),
          decoration: pageDecoration,
          footer: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //------------------------------------------------------------------------------------- GPT KEY
                    SizedBox(
                      width: width * .72,
                      height: height * .1,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity: .8,
                          color: const Color(0xFF252525),
                          shadowDarkColor: Colors.black,
                          depth: 3,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(40)),
                          oppositeShadowLightSource: false,
                        ),
                        child: TextField(
                          controller: inputGPTKeyController,
                          cursorColor: const Color(0xFFE7ECEF),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 16),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFF252525),
                            hintText: "sk-5yg2...",
                            hintStyle: textTheme.bodyMedium!.copyWith(
                                color: const Color(0xFFE7ECEF).withOpacity(.5),
                                fontStyle: FontStyle.italic),
                            suffixIcon: const Icon(
                              Icons.create,
                              color: Color(0xFFE7ECEF),
                            ),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            //save the api key
                            widget.apiKeyStorageHelper
                                .saveGPTAPIKey(inputGPTKeyController.text);
                            FocusManager.instance.primaryFocus?.unfocus();

                            //pop up telling the user it was saved
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.12,
                      height: height * 0.10,
                      child: NeumorphicButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        minDistance: -5,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity:
                              provider.theme == ThemeMode.light ? .8 : .6,
                          color: const Color(0xFF252525),
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
                            color: Color(0xFFE7ECEF),
                          ),
                        ),
                        onPressed: () {
                          //save the api key
                          widget.apiKeyStorageHelper
                              .saveGPTAPIKey(inputGPTKeyController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.1,
                child: NeumorphicButton(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  minDistance: -5,
                  style: NeumorphicStyle(
                    lightSource: LightSource.topLeft,
                    intensity: provider.theme == ThemeMode.light ? .8 : .6,
                    color: const Color(0xFF252525),
                    shadowDarkColor: Colors.black,
                    shadowLightColorEmboss: Colors.white,
                    shadowDarkColorEmboss: Colors.black,
                    depth: 2,
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child: Center(
                    //animation for the confirmation
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "GET KEY",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFE7ECEF),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FaIcon(
                          FontAwesomeIcons.arrowRightToBracket,
                          size: 15,
                          color: Color(0xFFE7ECEF),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _launchGPTUrl();
                  },
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "ElevenLabs API Key Setup",
          body: "Enter your ElevenLabs API Key",
          image: _buildLottieImage('outlined_circle.json', true, 500),
          decoration: pageDecoration,
          footer: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //------------------------------------------------------------------------------------- EL KEY
                    SizedBox(
                      width: width * .72,
                      height: height * .1,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity: .8,
                          color: const Color(0xFF252525),
                          shadowDarkColor: Colors.black,
                          depth: 3,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(40)),
                          oppositeShadowLightSource: false,
                        ),
                        child: TextField(
                          controller: inputElLabsKeyController,
                          cursorColor: const Color(0xFFE7ECEF),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 16),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: const Color(0xFF252525),
                            hintText: "23232...",
                            hintStyle: textTheme.bodyMedium!.copyWith(
                                color: const Color(0xFFE7ECEF).withOpacity(.5),
                                fontStyle: FontStyle.italic),
                            suffixIcon: const Icon(
                              Icons.create,
                              color: Color(0xFFE7ECEF),
                            ),
                          ),
                          style: textTheme.bodyMedium,
                          enabled: true,
                          onEditingComplete: () {
                            //save the api key
                            widget.apiKeyStorageHelper
                                .saveELAPIKey(inputElLabsKeyController.text);
                            FocusManager.instance.primaryFocus?.unfocus();

                            //pop up telling the user it was saved
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.12,
                      height: height * 0.10,
                      child: NeumorphicButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.025),
                        minDistance: -5,
                        style: NeumorphicStyle(
                          lightSource: LightSource.topLeft,
                          intensity:
                              provider.theme == ThemeMode.light ? .8 : .6,
                          color: const Color(0xFF252525),
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
                            color: Color(0xFFE7ECEF),
                          ),
                        ),
                        onPressed: () {
                          //save the api key
                          widget.apiKeyStorageHelper
                              .saveELAPIKey(inputElLabsKeyController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.1,
                child: NeumorphicButton(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  minDistance: -5,
                  style: NeumorphicStyle(
                    lightSource: LightSource.topLeft,
                    intensity: provider.theme == ThemeMode.light ? .8 : .6,
                    color: const Color(0xFF252525),
                    shadowDarkColor: Colors.black,
                    shadowLightColorEmboss: Colors.white,
                    shadowDarkColorEmboss: Colors.black,
                    depth: 2,
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child: Center(
                    //animation for the confirmation
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "GET KEY",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFE7ECEF),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FaIcon(
                          FontAwesomeIcons.arrowRightToBracket,
                          size: 15,
                          color: Color(0xFFE7ECEF),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _launchELUrl();
                  },
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "Prompts",
          body:
              "Enhance your experience in AVA by using the prompts feature or by creating your own.",
          image: _buildLottieImage('triple_ven_diagram.json', true),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Adjusting API Parameters",
          body:
              "Fine-tune your experience in AVA by adjusting your API parameters with the sliders in the settings section.",
          image: _buildLottieImage('triangles.json', true),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Enjoy!",
          body:
              "Please leave a review on the App Store and share this app with your friends!",
          image: _buildLottieImage('slinky.json', true),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showNextButton: false,
      showBackButton: false,
      //back and next presets are here but not shown just incase I change my mind for future
      back: const Icon(
        Icons.arrow_back,
        color: Color(0xFFE7ECEF),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Color(0xFFE7ECEF),
      ),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFFE7ECEF),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color.fromARGB(255, 62, 62, 62),
        activeColor: Color(0xFFE7ECEF),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
