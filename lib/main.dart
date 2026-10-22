import 'dart:developer';

import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/auth_provider.dart';
import 'package:evently/providers/events_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/screens/add_and_edit_event.dart';
import 'package:evently/ui/screens/event_details_screen.dart';
import 'package:evently/ui/screens/login_screen.dart';
import 'package:evently/ui/screens/main_layout_screen.dart';
import 'package:evently/tabs/profile/profile_screen.dart';
import 'package:evently/ui/screens/register_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProviderService()..listenToAuthChange(),
        ),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(context.watch<LanguageProvider>().currentLanguage),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: context.watch<ThemeProvider>().currentTheme,
            routes: {
              AppRoutes.mainLayout: (context) => MainLayoutScreen(),
              AppRoutes.loginScreen: (context) => LoginScreen(),
              AppRoutes.profileScreen: (context) => ProfileScreen(),
              AppRoutes.addEventScreen: (context) => AddAndEditEventScreen(),
              AppRoutes.registerScreen: (context) => RegisterScreen(),
              AppRoutes.eventDetailsScreen: (context) => EventDetailsScreen(),
            },
            home: AuthGate(),
          );
        },
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProviderService>();

    if (authProvider.currentUser == null) {
      return LoginScreen();
    } else {
      log(FirebaseAuth.instance.currentUser!.email!);
      log('${authProvider.currentUser?.email}+ this is email');
      return MainLayoutScreen();
    }
  }
}
