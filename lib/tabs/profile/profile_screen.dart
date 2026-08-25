import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          
          spacing: 20,
          children: [
            ProfilePicture(),
            SizedBox(height: 10),
            SettingWidget(
              label: AppLocalizations.of(context)!.language,
              onTap: () {
                context.read<LanguageProvider>().changLanguage();
              },
            ),
            SettingWidget(
              label: AppLocalizations.of(context)!.theme,
              onTap: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      height: 124,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1000),
          topRight: Radius.circular(1000),
          bottomLeft: Radius.circular(1000),
          bottomRight: Radius.circular(1000),
        ),
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  const SettingWidget({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Text(label, style: AppTextStyle.headLine),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryLightMode),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  'Arabic',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down, size: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*() {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [Text('English'), Text('Arabic')],
                  ),
                ),
              ),
            );
          } */

         /*Row(
          children: [
            ProfilePicture(),
            SizedBox(width: 20),
            Flexible(
              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Mohamed elsayed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'mohamedelsayed2004@gmail.com',
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ), */
