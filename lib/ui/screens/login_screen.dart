import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_svg_pic.dart';
import 'package:evently/ui/widgets/custom_text_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().currentTheme;
    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Text(l10n.login_to_your_account, style: AppTextStyle.font24Text),
              SizedBox(height: height * .02),
              CustomTextFormField(
                hintText: l10n.enter_your_email,
                prefixIcon: CustomSvgPicture(svgPath: Assets.smsSVG),
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                hintText: l10n.enter_your_password,
                prefixIcon: CustomSvgPicture(svgPath: Assets.lockSVG),
              ),
              Row(
                children: [
                  Spacer(),
                  CustomTextButton(onTap: () {}, text: l10n.forget_password),
                ],
              ),
              SizedBox(height: height * .05),
              CustomButton(onTap: () {}, text: l10n.login),
            ],
          ),
        ),
      ),
    );
  }
}
