import 'package:ava_v2/view_models/export_view_models.dart';
import 'package:ava_v2/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/export_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // lock the app into portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //run the app
  runApp(const Ava());
}

class Ava extends StatelessWidget {
  const Ava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
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
      child: Consumer<ThemeProvider>(
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
            // home: const Home(),
            home: const OnBoardingPage(),
          );
        },
      ),
    );
  }
}
