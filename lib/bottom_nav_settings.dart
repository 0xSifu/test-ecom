import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/models/bottom_nav_model.dart';
import 'package:ufo_elektronika/screens/home/home_screen.dart';
import 'package:ufo_elektronika/screens/live_chat_screen.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_screen.dart';
import 'package:ufo_elektronika/screens/news/news_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_screen.dart';
import 'package:ufo_elektronika/screens/account/account_screen.dart';

class BottomNavSettings {
  final List<BottomNavModel> _bottomNavMenus = [
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/home-icon_active.png'),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/home-icon_default.png'),
      ),
      label: 'Beranda',
      pageWidget: () => const HomeScreen(key: Key("Home")),
      url: '/',
    ),
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/categories-icon_active.png'),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child:
            Image.asset('assets/icon/bottom-nav/categories-icon_default.png'),
      ),
      label: 'Kategori',
      pageWidget: () => const MainMenuScreen(key: Key("Menu")),
      url: '/main-menu',
    ),
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset(
          'assets/icon/bottom-nav/receipt_long_active.png',
          color: AppColor.yellow,
        ),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/receipt_long_default.png'),
      ),
      label: 'Transaksi',
      pageWidget: () => const TransactionScreen(key: Key("Transaction")),
      url: '/transaction',
    ),
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/news-icon_default.png', color: const Color(0XFFFED100),),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/news-icon_default.png'),
      ),
      label: 'UFO News',
      pageWidget: () => const NewsScreen(key: Key("Live Chat")),
      url: '/news',
    ),
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/live-chat.png'),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/live-chat.png'),
      ),
      label: 'Live Chat',
      pageWidget: () => LiveChatScreen(key: const Key("Live Chat")),
      url: '/live-chat',
    ),
    BottomNavModel(
      selectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/user_active.png'),
      ),
      unselectedIcon: SizedBox(
        height: 20,
        child: Image.asset('assets/icon/bottom-nav/user_default.png'),
      ),
      label: 'Akun',
      pageWidget: () => const AccountScreen(key: Key("User")),
      url: '/user',
    ),
  ];

  List<BottomNavModel> get bottomNavMenus => _bottomNavMenus;
}
