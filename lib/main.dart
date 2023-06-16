import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'database/api_key_storage_helper.dart';
import 'database/prompt_storage_helper.dart';
import 'providers/export_providers.dart';
import '../view_models/export_view_models.dart';
import 'views/home_screen.dart';
import 'views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // lock the app into portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  //-------------------------------------------------------------------------------------
  /*
  Secure storage created at root of widget tree so it's available in 
  onboarding_screen.dart & home_screen.dart for both the API keys.
  */
  final APIKeyStorageHelper apiKeyStorageHelper = APIKeyStorageHelper();

/*
Setup Database 

promptStorageHelper - 
promptStorageHelper.database -
promptList -
 */
  final PromptStorageHelper promptStorageHelper = PromptStorageHelper();
  await promptStorageHelper.database;
  final List<Map> promptList = await promptStorageHelper.getAllData();

  //----------------------------------------------------------------------------------------

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingIconGPTProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoadingIconELProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GPTAPIViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ELAPIViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatHistoryProvider(),
        ),
      ],
      //pass the api key database and the prompt database helpers to the main app
      child: Ava(
        apiKeyStorageHelper: apiKeyStorageHelper,
        promptList: promptList,
        showHome: showHome,
      ),
    ),
  );
}

class Ava extends StatefulWidget {
  final bool showHome;
  final APIKeyStorageHelper apiKeyStorageHelper;
  final List<Map>? promptList;

  const Ava({
    Key? key,
    required this.showHome,
    required this.apiKeyStorageHelper,
    required this.promptList,
  }) : super(key: key);

  @override
  State<Ava> createState() => _AvaState();
}

class _AvaState extends State<Ava> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'AVA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // light theme settings
            useMaterial3: true,

            /* light theme color settings */
            colorScheme: const ColorScheme.light(
              background: Color(0xFFE7ECEF),
              primary: Color(0xFFE7ECEF),
              secondary: Color(0xFF252525),
            ),
            textTheme: GoogleFonts.montserratTextTheme(
              const TextTheme(
                bodyMedium: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 16.0,
                ),
                bodyLarge: TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 25.0,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            dialogTheme: DialogTheme(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.white,
              iconColor: const Color(0xFFE7ECEF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  color: Color(0xFF252525),
                  width: 5.0,
                ),
              ),
            ),
          ),
          darkTheme: ThemeData(
            // dark theme settings
            useMaterial3: true,

            //changes the background color of the app thumbnail
            colorScheme: const ColorScheme.dark(
              background: Color(0xFF252525),
              primary: Color(0xFF252525),
              secondary: Color(0xFFE7ECEF),
            ),
            textTheme: GoogleFonts.montserratTextTheme(
              const TextTheme(
                bodyMedium: TextStyle(
                  color: Color(0xFFE7ECEF),
                  fontSize: 16.0,
                ),
                bodyLarge: TextStyle(
                  color: Color(0xFFE7ECEF),
                  fontSize: 25.0,
                  letterSpacing: 2.5,
                ),
              ),
            ),

            dialogTheme: DialogTheme(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.white,
              iconColor: const Color(0xFFE7ECEF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  color: Color(0xFFE7ECEF),
                  width: 5.0,
                ),
              ),
            ),
          ),
          themeMode: provider.theme,
          home: widget.showHome
              ? Home(
                  //pass the same secure storage object down to home now so we can print this in the settings section
                  apiKeyStorageHelper: widget.apiKeyStorageHelper,
                  promptList: widget.promptList,
                )
              : OnBoardingPage(
                  apiKeyStorageHelper: widget.apiKeyStorageHelper,
                  promptList: widget.promptList,
                ),
        );
      },
    );
  }
}
