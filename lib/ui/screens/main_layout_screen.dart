import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/tab_info.dart';
import 'package:evently/tabs/home/home_tab_content.dart';
import 'package:evently/tabs/profile/profile_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_routes.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final List<Widget> tabsContent = [
   HomeTabContent(),
    Container(),
    ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEventScreen);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      bottomNavigationBar: _BottomNav(
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        currentIndex: currentIndex,
      ),
      body: tabsContent[currentIndex],
    );
  }
}

class _BottomNav extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;

  const _BottomNav({super.key, this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
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

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
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
    );
  }
}
