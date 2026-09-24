import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/auth_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/ui/widgets/custom_text_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/google_button.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isObscure = true;
  bool isConfirmPasswordHidden = true;
  String name = '';
  String email = '';
  String password = '';
  late final ThemeMode themeMode;
  late final ThemeData theme;
  late final double height;
  late final AppLocalizations l10n;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeMode = context.watch<ThemeProvider>().currentTheme;
    theme = Theme.of(context);
    height = MediaQuery.sizeOf(context).height;
    l10n = AppLocalizations.of(context)!;
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthProviderService>().register(
        email: email,
        password: password,
        name: name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    l10n.create_your_account,
                    style: AppTextStyle.font24Text,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    hintText: l10n.enter_your_name,
                    prefixIcon: CustomSvgPicture(svgPath: Assets.userSvg),
                    onChange: (data) => name = data,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.pleaseEnterYourName;
                      }

                      if (!RegExp(
                        r'^[a-zA-Z\u0600-\u06FF ]+$',
                      ).hasMatch(value.trim())) {
                        return l10n.nameCanOnlyContainLetters;
                      }
                      return null;
                    },
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

                      if (value.length < 6) {
                        return l10n.passwordMustBeAtLeast6Characters;
                      }

                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return l10n.passwordMustContainAtLeastOneNumber;
                      }

                      if (!RegExp(
                        r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]]',
                      ).hasMatch(value)) {
                        return l10n
                            .passwordMustContainAtLeastOneSpecialCharacter;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    hintText: l10n.confirm_your_password,
                    obscureText: isConfirmPasswordHidden,
                    prefixIcon: CustomSvgPicture(svgPath: Assets.lockSVG),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                      icon: FaIcon(
                        isConfirmPasswordHidden
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: AppColor.disable,
                      ),
                    ),
                    validator: (value) {
                      if (value != password) {
                        return l10n.passwordsDoNotMatch;
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: height * .05),
                  CustomButton(
                    onTap: () async {
                      await register(
                        email: email,
                        password: password,
                        name: name,
                      );
                    },
                    text: l10n.sign_up,
                  ),
                  SizedBox(height: height * .05),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        l10n.already_have_an_account,
                        style: AppTextStyle.font14TextW600.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      CustomTextButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        text: l10n.login,
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
                  GoogleButton(onTap: () {}, text: l10n.sign_up_with_google),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
