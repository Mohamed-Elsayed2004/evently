import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/tab_info.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final List<Widget> tabsContent = [Container(), Container(), Container()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomNav(
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        currentIndex: currentIndex,
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;
  const _BottomNav({super.key, this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final List<TabInfo> tabs = [
      TabInfo(
        tabImage: 'assets/svg/home-2.svg',
        label: AppLocalizations.of(context)!.home,
      ),
      TabInfo(
        tabImage: 'assets/svg/heart.svg',
        label: AppLocalizations.of(context)!.favorite,
      ),
      TabInfo(
        tabImage: 'assets/svg/user.svg',
        label: AppLocalizations.of(context)!.profile,
      ),
    ];

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 0,
      
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedFontSize: 15,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: List.generate(3, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(tabs[index].tabImage),
            activeIcon: SvgPicture.asset(
              tabs[index].tabImage,
      
              colorFilter: ColorFilter.mode(
                AppColor.primaryLightMode,
                BlendMode.srcIn,
              ),
            ),
            label: tabs[index].label,
          );
        }),
      ),
    );
  }
}
