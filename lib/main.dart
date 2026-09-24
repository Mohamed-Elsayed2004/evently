import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/auth_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/screens/add_event.dart';
import 'package:evently/ui/screens/login_screen.dart';
import 'package:evently/ui/screens/main_layout_screen.dart';
import 'package:evently/tabs/profile/profile_screen.dart';
import 'package:evently/ui/screens/register_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProviderService()),
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
              AppRoutes.addEventScreen: (context) => AddEventScreen(),
              AppRoutes.registerScreen: (context) => RegisterScreen(),
            },
            initialRoute: AppRoutes.loginScreen,
          );
        },
      ),
    );
  }
}
