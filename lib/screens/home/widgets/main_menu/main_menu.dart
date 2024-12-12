import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/find_order/find_order_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List menus = [
      {
        'image': 'assets/icon/menu/clearence-sale.webp',
        'label': 'Clearance Sale Up To 70%',
        'url': CategoryScreen.routeName,
        'id': "clearance_sale"
      },
      {
        'image': 'assets/icon/menu/online-store.webp',
        'label': 'Click and\nCollect',
        'url': CategoryScreen.routeName,
        'type': CategoryScreen.clickAndCollect
      },
      {
        'image': 'assets/icon/menu/voucher.webp',
        'label': 'Free Voucher',
        'url': VoucherScreen.routeName,
      },
      {
        'image': 'assets/icon/menu/pickup.webp',
        'label': 'Lacak Pesanan',
        'url': FindOrderScreen.routeName,
      },
      {
        'image': 'assets/icon/menu/gadgets.webp',
        'label': 'Gadget\non Top',
        'url': CategoryScreen.routeName,
        'id': "gadget_on_top"
      },
      {
        'image': 'assets/icon/menu/official-brand.png',
        'label': 'Official Brand',
        'url': CategoryScreen.routeName,
        'type': CategoryScreen.officialBrands
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var menu in menus)
            Expanded(
              child: InkWell(
                onTap: () {
                  final parameters = <String, String>{};

                  if (menu["id"] != null) {
                    parameters["id"] = menu["id"];
                  }

                  if (menu["type"] != null) {
                    parameters["type"] = menu["type"];
                  }
                  menu["url"] == null ? null : Get.toNamed(menu['url'], parameters: parameters);
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(menu['image']),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      menu['label'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'MYRIADPRO',
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
