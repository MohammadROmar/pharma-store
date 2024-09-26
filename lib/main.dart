import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/models/medicine.dart';

import 'generated/l10n.dart';

import 'package:project/screens/tabs.dart';
import 'package:project/screens/login.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/profile.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 49, 231, 255),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 49, 255, 248),
);

bool m(Medicine ml) {
  return false;
}

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  String language = 'en';
  var isSignedin = false;
  User? user;
  ThemeMode themeMode = ThemeMode.system;

  void onChangeLanguage(String selectedLanguage) {
    if (selectedLanguage != language) {
      setState(() {
        language = selectedLanguage;
      });
    }
  }

  void signedin({required bool isSignedin, User? user}) {
    setState(() {
      this.isSignedin = isSignedin;
      this.user = isSignedin ? user : null;
    });
  }

  void onChangeTheme(ThemeMode theme) {
    setState(() {
      themeMode = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmaStore',
      debugShowCheckedModeBanner: false,
      locale: Locale(language),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: themeMode,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.secondaryContainer,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.primaryContainer.withOpacity(1.0),
        ),
        drawerTheme: const DrawerThemeData().copyWith(
          backgroundColor: kColorScheme.surfaceTint,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: const ButtonStyle().copyWith(
            backgroundColor: MaterialStatePropertyAll(
              kColorScheme.primary,
            ),
            foregroundColor: MaterialStatePropertyAll(
              kColorScheme.primaryContainer,
            ),
          ),
        ),
        textTheme: const TextTheme().copyWith(
          bodyLarge: const TextStyle().copyWith(
            color: kColorScheme.inversePrimary,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
      ),
      // home: isSignedin && user != null
      //     ? TabsScreen(
      //         user: user!,
      //         onChangeLanguage: onChangeLanguage,
      //         signedin: signedin,
      //         onChangeTheme: onChangeTheme)
      //     : LoginScreen(signedin: signedin, onChangeLanguage: onChangeLanguage),
      home: TabsScreen(
          onChangeLanguage: onChangeLanguage,
          user: User(name: 'name', phoneNum: 'phoneNum', password: 'password'),
          signedin: signedin,
          onChangeTheme: onChangeTheme),
    );
  }
}
