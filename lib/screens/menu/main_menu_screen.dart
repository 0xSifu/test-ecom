import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_controller.dart';
import 'package:ufo_elektronika/shared/utils/html_unescape/html_unescape_small.dart';
import 'package:ufo_elektronika/widgets/appbar/action_bar_widget.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar_search_input.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class MainMenuScreen extends GetView<MainMenuController> {
  static const routeName = "/main-menu";
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(title: null),
      body: Obx(() {
        if (controller.menus.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            if (controller.canGoUp)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: InkWell(
                  onTap: controller.goUp,
                  highlightColor: Colors.transparent,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.close,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            // if (controller.selectedCategory.value != null && controller.selectedCategory.value != null && controller.canGoUp)
            //   Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         child: ListTile(
            //           title: Text(
            //             HtmlUnescape().convert(controller.selectedCategory.value?.name ?? ""),
            //             style: const TextStyle(
            //               fontSize: 14,
            //             ),
            //           ),
            //           trailing: const Icon(
            //             Icons.chevron_right,
            //             color: AppColor.primaryColor,
            //           ),
            //           contentPadding: const EdgeInsets.all(0),
            //           dense: true,
            //           visualDensity: VisualDensity.compact,
            //           enableFeedback: true,
            //           onTap: () {
            //             Get.toNamed(CategoryScreen.routeName, parameters: { "id": "${controller.selectedCategory.value?.categoryId}" });
            //           },
            //         ),
            //       )
            //     ],
            //   ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: controller.currentCategories.length,
                  itemBuilder: (context, index) {
                    final menuItem = controller.currentCategories[index];
                    final nextItems = menuItem.childLv4 ??
                        menuItem.childLv3 ??
                        menuItem.children;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              HtmlUnescape().convert(menuItem.name ?? ""),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: AppColor.primaryColor,
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            enableFeedback: true,
                            onTap: () {
                              Get.toNamed(CategoryScreen.routeName,
                                  parameters: {"id": "${menuItem.categoryId}"});
                            },
                          ),
                        ),
                        if (nextItems.isNotEmpty)
                          Container(
                            height: 76,
                            color: const Color(0xFFF7F7F7),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: nextItems.length,
                              itemBuilder: (context, index) {
                                final menuItemChild = nextItems[index];
                                return InkWell(
                                  onTap: () {
                                    controller.selectCategory(menuItemChild);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 52,
                                        child: Column(
                                          children: [
                                            if (menuItemChild.icon == null)
                                              Container(
                                                  width: 33,
                                                  height: 33,
                                                  color: Colors.grey),
                                            if (menuItemChild.icon != null &&
                                                menuItemChild.icon!.isNotEmpty)
                                              UEImage2(
                                                menuItemChild.icon ?? "",
                                                height: 33,
                                                width: 33,
                                              ),
                                            const SizedBox(height: 8),
                                            Text(menuItemChild.name ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 10))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10)
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
