import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/auth_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_back_button.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String email = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = context.watch<ThemeProvider>().currentTheme;
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: themeMode == ThemeMode.light
            ? AppColor.primaryLightMode
            : AppColor.primaryDarkMode,
      ),
      inAsyncCall: context.watch<AuthProviderService>().isLoading,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(),
            leadingWidth: 40,
            title: Text(l10n.forget_password_title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                spacing: 24,
                children: [
                  Image.asset(
                    themeMode == ThemeMode.light
                        ? Assets.changeSetting
                        : Assets.changeSettingDark,
                  ),
                  CustomTextFormField(
                    hintText: l10n.enter_your_email,
                    prefixIcon: CustomSvgPicture(svgPath: Assets.smsSVG),
                    onChange: (data) => email = data,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.pleaseEnterYourEmail;
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return l10n.pleaseEnterAValidEmail;
                      }

                      return null;
                    },
                  ),
                  CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final provider = context.read<AuthProviderService>();
                        await provider.resetPasswordTrigger(email: email);
                        if (provider.errorMessage == null && context.mounted) {
                          Navigator.pop(context);
                          showSnackBar(context, l10n.passwordResetSuccess);
                        } else if (context.mounted) {
                          showSnackBar(context, provider.errorMessage!);
                        }
                      }
                    },
                    text: l10n.reset_password,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
