import 'package:ava_v2/providers/export_providers.dart';
import 'package:ava_v2/views/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  TextEditingController inputGPTKeyController = TextEditingController();
  TextEditingController inputElLabsKeyController = TextEditingController();

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
          gptKey: inputGPTKeyController.text,
          elLabsKey: inputElLabsKeyController.text,
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String assetName, double width) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  Widget _buildLottieImage(String assetName, [double height = 350]) {
    return Center(
      child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          child: Lottie.asset(
            'assets/lottie/$assetName',
            height: height,
          )),
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
    final settingsProvider = Provider.of<SettingsProvider>(context);

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
          image: _buildLottieImage('polygonal_star.json', 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "API Keys Setup",
          body: "To use this app, you must enter your own API keys.",
          image: _buildLottieImage('outlined_circle.json', 500),
          decoration: pageDecoration,
          footer: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Required",
                  style: textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFFE7ECEF),
                      fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //------------------------------------------------------------------------------------- GPT KEY
                      SizedBox(
                        width: width * .5,
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
                              hintText: "GPT-3.5-Turbo Key",
                              hintStyle: textTheme.bodyMedium!.copyWith(
                                  color:
                                      const Color(0xFFE7ECEF).withOpacity(.5),
                                  fontStyle: FontStyle.italic),
                              suffixIcon: const Icon(
                                Icons.create,
                                color: Color(0xFFE7ECEF),
                              ),
                            ),
                            style: textTheme.bodyMedium,
                            enabled: true,
                            onEditingComplete: () {
                              //autosave the anytext removed or added from this textfield
                              settingsProvider
                                  .setGPTAPIKey(inputGPTKeyController.text);
                              FocusManager.instance.primaryFocus?.unfocus();

                              //pop up telling the user it was saved
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.3,
                        height: height * 0.1,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text("GET KEY",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFFE7ECEF))),
                              FaIcon(
                                FontAwesomeIcons.arrowRightToBracket,
                                size: 15,
                                color: Color(0xFFE7ECEF),
                              ),
                            ],
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
                //------------------------------------------------------------------------------------- EL LABS KEY
                Text(
                  "Optional",
                  style: textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFFE7ECEF),
                      fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * .5,
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
                              hintText: "ElevenLabs Key (Optional)",
                              hintStyle: textTheme.bodyMedium!.copyWith(
                                  color:
                                      const Color(0xFFE7ECEF).withOpacity(.5),
                                  fontStyle: FontStyle.italic),
                              suffixIcon: const Icon(Icons.create,
                                  color: Color(0xFFE7ECEF)),
                            ),
                            style: textTheme.bodyMedium,
                            enabled: true,
                            onEditingComplete: () {
                              //autosave the anytext removed or added from this textfield
                              settingsProvider.setElLabsAPIKey(
                                  inputElLabsKeyController.text);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.3,
                        height: height * 0.1,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text("GET KEY",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFFE7ECEF))),
                              FaIcon(
                                FontAwesomeIcons.arrowRightToBracket,
                                size: 15,
                                color: Color(0xFFE7ECEF),
                              ),
                            ],
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
              ],
            ),
          ),
        ),
        PageViewModel(
          title: "Prompts",
          body:
              "Enhance your experience in AVA by using the prompts feature or by creating your own.",
          image: _buildLottieImage('triple_ven_diagram.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Adjusting API Parameters",
          body:
              "Fine-tune your experience in AVA by adjusting your API parameters with the sliders in the settings section.",
          image: _buildLottieImage('triangles.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Enjoy!",
          body:
              "Please leave a review on the App Store and share this app with your friends!",
          image: _buildLottieImage('slinky.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      // skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color(0xFF252525),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
