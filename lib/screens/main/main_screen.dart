import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/models/bottom_nav_model.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
class MainScreen extends GetView<MainController> {
  static const routeName = "/main";
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: controller.tabController,
      tabBar: CupertinoTabBar(
        onTap: controller.changeCurrentIndex,
        items: [
          for (BottomNavModel menu in controller.tabs)
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: menu.unselectedIcon,
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: menu.selectedIcon,
              ),
              label: menu.label,
            )
          ],
        ), 
      tabBuilder: (context, index) => controller.tabs[index].pageWidget()
    );
  }
}
