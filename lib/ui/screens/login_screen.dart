import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/auth_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/ui/widgets/custom_text_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/google_button.dart';
import 'package:evently/ui/widgets/show_snack_bar.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isObscure = true;
  bool isLoading = false;
  String email = '';
  String password = '';

  Future<void> login({required String email, required String password}) async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<AuthProviderService>();
      final bool success = await provider.login(
        email: email,
        password: password,
      );

      if (mounted) {
        if (success) {
          await provider.checkEmailVerification();
          if (!mounted) {
            return;
          } else if (provider.isEmailVerified) {
            showSnackBar(context, 'Welcome');
            Navigator.of(context).pushReplacementNamed(AppRoutes.mainLayout);
          }
        }
        if (!success && mounted) {
          showSnackBar(
            context,
            context.read<AuthProviderService>().errorMessage!,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().currentTheme;
    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final l10n = AppLocalizations.of(context)!;
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: themeMode == ThemeMode.light
            ? AppColor.primaryLightMode
            : AppColor.primaryDarkMode,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: height * .02),
                    Center(
                      child: Image.asset(
                        fit: BoxFit.cover,
                        width: MediaQuery.sizeOf(context).width * .6,
                        height: height * .1,
                        themeMode == ThemeMode.dark
                            ? Assets.eventlyLogoDark
                            : Assets.eventlyLogoLight,
                      ),
                    ),
                    SizedBox(height: height * .04),
                    Text(
                      l10n.login_to_your_account,
                      style: AppTextStyle.font24Text,
                    ),
                    SizedBox(height: height * .02),
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
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: l10n.enter_your_password,
                      obscureText: isObscure,
                      prefixIcon: CustomSvgPicture(svgPath: Assets.lockSVG),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: FaIcon(
                          isObscure
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: AppColor.disable,
                        ),
                      ),
                      onChange: (data) => password = data,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterYourPassword;
                        }

                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Spacer(),
                        CustomTextButton(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.forgetPasswordScreen,
                            );
                          },
                          text: l10n.forget_password,
                        ),
                      ],
                    ),
                    SizedBox(height: height * .05),
                    CustomButton(
                      onTap: () async {
                        setState(() => isLoading = true);
                        await login(email: email, password: password);
                        setState(() => isLoading = false);
                      },
                      text: l10n.login,
                    ),
                    SizedBox(height: height * .05),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          l10n.dont_have_an_account,
                          style: AppTextStyle.font14TextW600.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        CustomTextButton(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.registerScreen);
                          },
                          text: l10n.sign_up,
                        ),
                      ],
                    ),
                    SizedBox(height: height * .025),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: .center,
                      children: [
                        SizedBox(
                          width: 146,
                          child: Divider(color: theme.colorScheme.outline),
                        ),

                        Text(
                          l10n.or,
                          style: AppTextStyle.font16Text.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(
                          width: 146,
                          child: Divider(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .025),
                    GoogleButton(onTap: () {}, text: l10n.login_with_google),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
