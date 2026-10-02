import 'package:evently/firebase/firebase_auth_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/tabs/profile/language_bar.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              children: [
                SizedBox(height: 12),
                ProfilePicture(),
                Text(
                  'Mohamed elsayed',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Text(
                  'mohamedelsayed2004@gmail.com',
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12),
                SettingWidget(
                  label: AppLocalizations.of(context)!.darkMode,
                  onTap: () {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                  trailing: Switch(
                    value:
                        context.watch<ThemeProvider>().currentTheme ==
                        ThemeMode.dark,
                    onChanged: (_) {
                      context.read<ThemeProvider>().toggleTheme();
                    },
                  ),
                ),
                LanguageBar(),
                SettingWidget(
                  onTap: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseAuthService.logoutUser();
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginScreen,
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showSnackBar(context, e.toString());
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  label: l10n.logout,
                  trailing: SvgPicture.asset('assets/svg/logout-02.svg'),
                ),
              ],
            ),
          ),
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
  final Widget trailing;
  const SettingWidget({
    super.key,
    required this.label,
    this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(label, style: AppTextStyle.headLine),

            Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
