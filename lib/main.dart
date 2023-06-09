import 'package:ava_v2/view_models/export_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'database/api_key_storage_helper.dart';
import 'database/prompt_storage_helper.dart';
import 'providers/export_providers.dart';
// import 'views/home_screen.dart';
import 'views/onboarding_screen.dart';

//TODO - fix the initialize DB issues
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // lock the app into portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /*
  Secure storage created at root of widget tree so it's available in 
  onboarding_screen.dart & home_screen.dart for both the API keys.
  */
  final APIKeyStorageHelper apiKeyStorageHelper = APIKeyStorageHelper();

  // Initialize the prompt storage database
  final PromptStorageHelper promptStorageHelper = PromptStorageHelper();
  //initialize the default prompts by adding them into the database
  // promptStorageHelper.initializeDefaultPrompts();
  // promptStorageHelper.deleteDB();

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
        promptStorageHelper: promptStorageHelper,
      ),
    ),
  );
}

class Ava extends StatelessWidget {
  final APIKeyStorageHelper apiKeyStorageHelper;
  final PromptStorageHelper promptStorageHelper;

  const Ava(
      {Key? key,
      required this.apiKeyStorageHelper,
      required this.promptStorageHelper})
      : super(key: key);

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
          // home: Home(
          //   //pass the same secure storage object down to home now so we can print this in the settings section
          //   apiKeyStorageHelper: apiKeyStorageHelper,
          //   promptStorageHelper: promptStorageHelper,
          // ),
          home: OnBoardingPage(
            apiKeyStorageHelper: apiKeyStorageHelper,
            promptStorageHelper: promptStorageHelper,
          ),
        );
      },
    );
  }
}
