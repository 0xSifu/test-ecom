import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/account/account_controller.dart';
import 'package:ufo_elektronika/screens/login/login_controller.dart';
import 'package:ufo_elektronika/screens/login/login_repository.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_screen.dart';
import 'package:ufo_elektronika/screens/user/address/address_screen.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_screen.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_screen.dart';
import 'package:ufo_elektronika/screens/webview/webview_screen.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_screen.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AccountScreen extends GetView<AccountController> {
  static const routeName = "/account";
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List mainMenus = [
      {
        'name': 'Alamat',
        'description': 'Atur alamat pengiriman',
        'icon': 'assets/icon/account/address.webp',
        'url': AddressScreen.routeName,
      },
      {
        'name': 'Favorit Saya',
        'description': '',
        'icon': 'assets/icon/account/heart.png',
        'url': WishlistScreen.routeName,
      },
      {
        'name': 'Voucher Saya',
        'description': '',
        'icon': 'assets/icon/account/promo.webp',
        'url': VoucherScreen.routeName,
      },
      {
        'name': 'UFO Poin',
        'description': '',
        'icon': 'assets/icon/account/ufo-point.png',
        'url': UfopointScreen.routeName,
      },
    ];

    final List otherInformation = [
      {
        'name': 'Lokasi Toko & Service Center',
        'icon': 'assets/icon/account/repair-shop.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/store/apps',
      },
      {
        'name': 'Keuntungan Member',
        'icon': 'assets/icon/account/membership.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/member/apps',
      },
      {
        'name': 'Garansi UFO PRO',
        'icon': 'assets/icon/account/clearence-sale.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/warranty/apps',
      },
      // {
      //   'name': 'UFO News',
      //   'icon': 'assets/icon/account/text-lines.webp',
      //   'url': 'ufo_news',
      // },
      {
        'name': 'Instalasi',
        'icon': 'assets/icon/account/wrench.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/instalasi/apps',
      },
      {
        'name': 'Pengiriman',
        'icon': 'assets/icon/account/truck-yellow.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/pengiriman/apps',
      },
      {
        'name': 'Click n Collect',
        'icon': 'assets/icon/account/online-store.webp',
        'url': 'https://www.ufoelektronika.com/index.php?route=information/click_collect/apps',
      },
      {
        'name': 'Beri Penilaian',
        'icon': 'assets/icon/account/rating.png',
        'url': MyReviewsScreen.routeName,
      },
    ];
    return Obx(() => Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.08),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: VisibilityDetector(
                key: const Key("account"), 
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction >= 0.9) {
                    controller.refreshProfile();
                  }
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isLoggedIn.value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.toNamed(UserUpdateScreen.routeName),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFED100),
                                      Color(0xFFF9C200)
                                    ]
                                  )
                                ),
                                child: SafeArea(
                                  bottom: false,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          if (controller.profile.value != null && controller.profile.value?.image?.isNotEmpty == true)
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(controller.profile.value?.image ?? "")
                                            )
                                          else
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: ThemeData.light().primaryColorLight
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Image.asset('assets/images/ufomen/ufomen-top.webp', width: 10, height: 10),
                                            ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.profile.value?.fullname ?? "",
                                                style: const TextStyle(
                                                  fontFamily: 'MYRIADPRO',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                              Text(
                                                controller.profile.value?.email ?? "",
                                                style: const TextStyle(
                                                  fontFamily: 'MYRIADPRO',
                                                  fontSize: 12
                                                ),
                                              ),
                                              if (controller.totalPoints.value.isNotEmpty)
                                                Column(
                                                  children: [
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset("assets/icon/account/ufo-point.webp", width: 27),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          controller.totalPoints.value,
                                                          style: const TextStyle(
                                                            fontFamily: 'MYRIADPRO',
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.bold,
                                                            color: AppColor.primaryColor
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.settings,
                                        color: AppColor.primaryColor,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),

                            /* -------------------------------- menu list ------------------------------- */
                            Container(
                              color: Colors.white,
                              height: 50,
                              child: Row(
                                children: [
                                  ...mainMenus.take(2).map((menu) => Expanded(
                                    child: InkWell(
                                      onTap: () => Get.toNamed(menu['url']),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 35,
                                              child: Image.asset(menu['icon']),
                                            ),
                                            const SizedBox(width: 23),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 17,
                                                    child: Text(
                                                      menu['name'],
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'MYRIADPRO',
                                                        color: Color(0xFF636363)
                                                      ),
                                                    ),
                                                  ),
                                                  if (menu["description"].toString().isNotEmpty)
                                                    SizedBox(
                                                      height: 13,
                                                      child: Text(
                                                        menu['description'],
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: 'MYRIADPRO',
                                                          color: Color(0xFF636363),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              color: Colors.white,
                              height: 50,
                              child: Row(
                                children: [
                                  ...mainMenus.skip(2).map((menu) => Expanded(
                                    child: InkWell(
                                      onTap: () => Get.toNamed(menu['url']),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 35,
                                              child: Image.asset(menu['icon']),
                                            ),
                                            const SizedBox(width: 23),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    menu['name'],
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'MYRIADPRO',
                                                      color: Color(0xFF636363),
                                                    ),
                                                  ),
                                                  if (menu["description"].toString().isNotEmpty)
                                                    Text(
                                                      menu['description'],
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: 'MYRIADPRO',
                                                        color: Color(0xFF636363),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            // const SizedBox(height: 10),
                          ],
                        )
                      else
                        SafeArea(child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: LoginScreen.loginComponent(LoginController(repository: LoginRepositoryImpl(dio: Get.find()), secureStorage: Get.find())),
                        )),

                      /* ------------------------------ pesanan saya ------------------------------ */
                      // Column(
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(15),
                      //       color: const Color(0xFFcae4f9),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Pesanan Saya'.toUpperCase(),
                      //             style: const TextStyle(
                      //               fontFamily: 'FuturaLT',
                      //               color: AppColor.primaryColor,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           InkWell(
                      //             onTap: () => Get.toNamed(TransactionScreen.routeName),
                      //             child: const Row(
                      //               children: [
                      //                 Text(
                      //                   'Lihat Riwayat Pesanan',
                      //                   style: TextStyle(
                      //                     fontFamily: 'MYRIADPRO',
                      //                     fontSize: 10,
                      //                     decoration: TextDecoration.underline,
                      //                     color: AppColor.primaryColor,
                      //                   ),
                      //                 ),
                      //                 Icon(
                      //                   Icons.chevron_right,
                      //                   size: 20,
                      //                   color: AppColor.primaryColor,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       padding: const EdgeInsets.all(15),
                      //       color: Colors.white,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           InkWell(
                      //             onTap: () => Get.toNamed(TransactionScreen.routeName),
                      //             child: SizedBox(
                      //               width: 70,
                      //               child: Column(
                      //                 children: [
                      //                   SizedBox(
                      //                     height: 30,
                      //                     child: Image.asset(
                      //                         'assets/icon/account/credit-card.webp'),
                      //                   ),
                      //                   const SizedBox(height: 10),
                      //                   const Text(
                      //                     'Belum Dibayar',
                      //                     style: TextStyle(
                      //                       fontSize: 10,
                      //                       color: Color(0xFF636363),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           InkWell(
                      //             onTap: () => Get.toNamed(TransactionScreen.routeName),
                      //             child: SizedBox(
                      //               width: 70,
                      //               child: Column(
                      //                 children: [
                      //                   SizedBox(
                      //                     height: 30,
                      //                     child: Image.asset(
                      //                         'assets/icon/account/package.webp'),
                      //                   ),
                      //                   const SizedBox(height: 10),
                      //                   const Text(
                      //                     'Dikemas',
                      //                     style: TextStyle(
                      //                       fontSize: 10,
                      //                       color: Color(0xFF636363),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           InkWell(
                      //             onTap: () => Get.toNamed(TransactionScreen.routeName),
                      //             child: SizedBox(
                      //               width: 70,
                      //               child: Column(
                      //                 children: [
                      //                   SizedBox(
                      //                     height: 30,
                      //                     child: Image.asset(
                      //                         'assets/icon/account/truck.webp'),
                      //                   ),
                      //                   const SizedBox(height: 10),
                      //                   const Text(
                      //                     'Dikirim',
                      //                     style: TextStyle(
                      //                       fontSize: 10,
                      //                       color: Color(0xFF636363),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           InkWell(
                      //             onTap: () => Get.toNamed(TransactionScreen.routeName),
                      //             child: SizedBox(
                      //               width: 70,
                      //               child: Column(
                      //                 children: [
                      //                   SizedBox(
                      //                     height: 30,
                      //                     child: Image.asset(
                      //                         'assets/icon/account/kid-star.webp'),
                      //                   ),
                      //                   const SizedBox(height: 10),
                      //                   const Text(
                      //                     'Beri Penilaian',
                      //                     style: TextStyle(
                      //                       fontSize: 10,
                      //                       color: Color(0xFF636363),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      /* --------------------------------- others --------------------------------- */
                      Container(
                        color: Colors.white,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: otherInformation.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 80,
                            crossAxisCount: 5,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 0,
                          ),
                          itemBuilder: (context, index) {
                            var menu = otherInformation.elementAt(index);

                            return InkWell(
                              onTap: () async {
                                if (menu["url"] == "rating") {
                                  final InAppReview inAppReview = InAppReview.instance;

                                  if (await inAppReview.isAvailable()) {
                                    inAppReview.requestReview();
                                  } else {
                                    // TODO: AppStore ID
                                    inAppReview.openStoreListing();
                                  }
                                } else if (menu['url'] == MyReviewsScreen.routeName) {
                                  Get.toNamed(menu['url']);
                                } else if (menu['url'] == "ufo_news") {
                                  Get.find<MainController>().changeCurrentIndex(3);
                                } else {
                                  Get.toNamed(WebViewScreen.routeName,
                                    parameters: {
                                      'title': menu['name'],
                                      'url': menu['url']
                                    });
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Image.asset(menu['icon']),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    menu['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'MYRIADPRO',
                                      fontSize: 10,
                                      color: Color(0xFF636363),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () => Get.toNamed(WebViewScreen.routeName, parameters: {
                          'title': 'Hubungi Customer Care',
                          'url':
                              'https://www.ufoelektronika.com/index.php?route=information/contact/apps',
                        }),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icon/account/customer-support.webp',
                                    width: 30,
                                  ),
                                  const SizedBox(width: 15),
                                  const Text(
                                    'Hubungi Customer Care',
                                    style: TextStyle(
                                      fontFamily: 'MYRIADPRO',
                                      fontSize: 15,
                                      color: Color(0xFF636363),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (controller.isLoggedIn.value)
                        Column(
                          children: [
                            InkWell(
                              onTap: () => Get.to(() => manageAccount, preventDuplicates: false),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                                color: Colors.white,
                                child: const Text("Kelola Akun",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'MYRIADPRO',
                                    fontSize: 15,
                                    color: Color(0xFF636363),
                                  )
                                )
                              ),
                            ),
                            const SizedBox(height: 5)
                          ],
                        ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              height: 50,
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(WebViewScreen.routeName, parameters: {
                                  'title': 'Syarat dan Ketentuan',
                                  'url':
                                      'https://www.ufoelektronika.com/index.php?route=information/terms_conditions/apps',
                                }),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                            color: Color(0xFFfafafa),
                                            width: 2,
                                          )),
                                        ),
                                        child: const Text(
                                          'Syarat dan Ketentuan',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'MYRIADPRO',
                                            fontSize: 15,
                                            color: Color(0xFF636363),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(WebViewScreen.routeName, parameters: {
                                  'title': 'Kebijakan Privasi',
                                  'url':
                                      'https://www.ufoelektronika.com/index.php?route=information/privacy_policy/apps',
                                }),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 15,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                            color: Color(0xFFfafafa),
                                            width: 2,
                                          )),
                                        ),
                                        child: const Text(
                                          'Kebijakan Privasi',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'MYRIADPRO',
                                            fontSize: 15,
                                            color: Color(0xFF636363),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (controller.isLoggedIn.value)
                        Container(
                          color: Colors.white,
                          child: InkWell(
                            onTap: Get.find<MainController>().signOut,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset("assets/icon/logout.png", width: 30),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 15,
                                    ),
                                    child: const Text(
                                      'Keluar',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'MYRIADPRO',
                                        fontSize: 15,
                                        color: Color(0xFF636363),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget get manageAccount => Scaffold(
    appBar: const UEAppBar(
      title: "KELOLA AKUN",
      showCart: false,
      showNotification: false,
    ),
    body: Container(
      color: Colors.grey.withOpacity(0.08),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => deleteAccount, preventDuplicates: false);
            },
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 28, right: 13, top: 10, bottom: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hapus Akun", style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF636363)
                  ),),
                  Icon(Icons.chevron_right, color: AppColor.primaryColor, size: 36)
                ],
              ),
            ),
          )
        ],
      ),
    )
  );

  Widget get deleteAccount => Scaffold(
    appBar: const UEAppBar(
      title: "HAPUS AKUN",
      showCart: false,
      showNotification: false,
    ),
    body: Container(
      color: Colors.grey.withOpacity(0.08),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
              child: Text("Apakah anda yakin ingin menghapus keseluruhan akun ini? proses ini akan menghapus semuanya, berupa Username, Wishlist, transaksi, dan lain sebagainya\n\nJika iya maka tekan tombol hapus akun anda", style: TextStyle(
                color: Color(0xFF636363),
                fontSize: 15
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Get.to(() => deleteAccountReason, preventDuplicates: false);
                      }, 
                      child: const Text("HAPUS AKUN ANDA")
                    ),
                  ),
                  const SizedBox(height: 1),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFEEEEEE)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                      ),
                      onPressed: () {
                        while (Get.currentRoute != MainScreen.routeName) {
                          Get.back();
                        }
                      }, 
                      child: const Text("BATALKAN", style: TextStyle(color: AppColor.primaryColor),)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    )
  );

  Widget get deleteAccountReason => Scaffold(
    body: Container(
      color: Colors.grey.withOpacity(0.08),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  child: Column(
                    children: [
                      Text("KENAPA ANDA MENINGGALKAN UFOE ELEKTRONIKA", style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16,
                        fontFamily: "FuturaLT",
                        fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 14),
                      Text("Beritahu kami alasan anda kenapa anda meninggalkan ufoe elektronika", style: TextStyle(
                        color: Color(0xFF636363),
                        fontSize: 15,
                      )),
                      SizedBox(height: 14),
                    ],
                  ),
                ),
                Column(
                  children: [
                    for (var i = 0; i < controller.accountDeletionReasons.length; i++)
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 28, right: 12),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.accountDeletionReasonIndex.value = i;
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(controller.accountDeletionReasons[i]["reason"] ?? "", style: const TextStyle(
                                            color: Color(0xFF636363),
                                            fontSize: 15,
                                          )),

                                          Obx(() => Radio<int?>(value: i, groupValue: controller.accountDeletionReasonIndex.value, onChanged: (value) {
                                            controller.accountDeletionReasonIndex.value = value;
                                          }))
                                        ],
                                      ),
                                      if (controller.accountDeletionReasons[i]["notes"] != null)
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.only(top: 1, bottom: 8),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFFEEEEEE)),
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Text(controller.accountDeletionReasons[i]["notes"] ?? "", style: const TextStyle(
                                            color: Color(0xFF636363),
                                            fontSize: 11
                                          )),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFEEEEEE))
                        ],
                      )
                  ],
                )
              ]
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        controller.deleteAccount();
                      }, 
                      child: const Text("HAPUS AKUN ANDA")
                    ),
                  ),
                  const SizedBox(height: 1),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFEEEEEE)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                      ),
                      onPressed: () {
                        Get.back();
                      }, 
                      child: const Text("LEWATI", style: TextStyle(color: AppColor.primaryColor),)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    )
  );
}
