import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:ufo_elektronika/constants/themes.dart';
import 'package:ufo_elektronika/providers/cart_provider.dart';
import 'package:ufo_elektronika/screens/account/account_binding.dart';
import 'package:ufo_elektronika/screens/account/account_screen.dart';
import 'package:ufo_elektronika/screens/brand_screen.dart';
import 'package:ufo_elektronika/screens/cart/cart_controller.dart';
import 'package:ufo_elektronika/screens/cart/cart_repository.dart';
import 'package:ufo_elektronika/screens/cart/cart_screen.dart';
import 'package:ufo_elektronika/screens/category/category_binding.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_binding.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_binding.dart';
import 'package:ufo_elektronika/screens/checkout_payment_confirmation/manual/checkout_payment_manual_screen.dart';
import 'package:ufo_elektronika/screens/checkout_processing_screen.dart';
import 'package:ufo_elektronika/screens/checkout/checkout_screen.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_binding.dart';
import 'package:ufo_elektronika/screens/compare_product/compare_product_screen.dart';
import 'package:ufo_elektronika/screens/find_order/find_order_screen.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_binding.dart';
import 'package:ufo_elektronika/screens/forgot_password/forgot_password_screen.dart';
import 'package:ufo_elektronika/screens/home/home_binding.dart';
import 'package:ufo_elektronika/screens/home/widgets/recommendation/recommendation_binding.dart';
import 'package:ufo_elektronika/screens/information/information_binding.dart';
import 'package:ufo_elektronika/screens/information/information_screen.dart';
import 'package:ufo_elektronika/screens/live_chat_screen.dart';
import 'package:ufo_elektronika/screens/login/login_binding.dart';
import 'package:ufo_elektronika/screens/login/login_screen.dart';
import 'package:ufo_elektronika/screens/main/main_binding.dart';
import 'package:ufo_elektronika/screens/main/main_controller.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_binding.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_screen.dart';
import 'package:ufo_elektronika/screens/main/main_screen.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_binding.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_screen.dart';
import 'package:ufo_elektronika/screens/news/news_binding.dart';
import 'package:ufo_elektronika/screens/payment_method_screen.dart';
import 'package:ufo_elektronika/screens/checkout_success_screen.dart';
import 'package:ufo_elektronika/screens/product/product_binding.dart';
import 'package:ufo_elektronika/screens/product_review_screen.dart';
import 'package:ufo_elektronika/screens/product/product_screen.dart';
import 'package:ufo_elektronika/screens/refund/refund_binding.dart';
import 'package:ufo_elektronika/screens/refund/refund_screen.dart';
import 'package:ufo_elektronika/screens/register/register_binding.dart';
import 'package:ufo_elektronika/screens/register/register_screen.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_binding.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_screen.dart';
import 'package:ufo_elektronika/screens/splash_screen/splash_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_binding.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_binding.dart';
import 'package:ufo_elektronika/screens/transaction_detail/transaction_detail_screen.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_screen.dart';
import 'package:ufo_elektronika/screens/user/address/address_binding.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_binding.dart';
import 'package:ufo_elektronika/screens/user/address_add_update/address_add_update_screen.dart';
import 'package:ufo_elektronika/screens/user/address/address_screen.dart';
import 'package:ufo_elektronika/screens/user/change_password_screen.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_binding.dart';
import 'package:ufo_elektronika/screens/user/notification/notification_screen.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_binding.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_screen.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_binding.dart';
import 'package:ufo_elektronika/screens/user/update/user_update_screen.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_binding.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_controller.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_repository.dart';
import 'package:ufo_elektronika/screens/user/voucher/voucher_screen.dart';
import 'package:ufo_elektronika/screens/webview/webview_binding.dart';
import 'package:ufo_elektronika/screens/webview/webview_controller.dart';
import 'package:ufo_elektronika/screens/webview/webview_screen.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_binding.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_controller.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_repository.dart';
import 'package:ufo_elektronika/screens/wishlist/wishlist_screen.dart';
import 'package:ufo_elektronika/shared/flavors/flavor_config.dart';
import 'package:ufo_elektronika/shared/networking/authorization_interceptor.dart';
import 'package:ufo_elektronika/shared/networking/crashlytic_interceptor.dart';
import 'package:ufo_elektronika/shared/networking/header_interceptor.dart';
import 'package:ufo_elektronika/shared/networking/session_interceptor.dart';
import 'package:ufo_elektronika/shared/providers/midtrans_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:ufo_elektronika/shared/services/firebase_main_service.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:version/version.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  // bool _isAppLinksInitialized = false;
  final _midtransProvider = MidtransProvider();
  late final firebaseService = FirebaseService();
  final RouteObserver routeObserver = RouteObserver();
  bool _hasSetupPackageInfo = false;
  bool _hasSetupApplink = false;

  @override
  void initState() {
    // init local date
    initializeDateFormatting('in_ID');
    Intl.defaultLocale = 'in_ID';
    super.initState();
    firebaseService.initializeFlutterFirebase(() => Get.context).then((value) {
      // We are waiting for remote config value
      initMidtrans();
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }
  

  void initAppLinks() async {
    if (_hasSetupApplink) return;
    _hasSetupApplink = true;
    _appLinks = AppLinks();

    // Get the initial/first link.
    // This is useful when app was terminated (i.e. not started)
    // final uri = await _appLinks.getInitialAppLink();
    // if (uri != null && !_isAppLinksInitialized) {
    //   _isAppLinksInitialized = true;
    //   debugPrint("Initial Applink ${uri.toString()}");
    //   openAppLink(uri);
    // }
    // Do something (navigation, ...)

    // Subscribe to further events when app is started.
    // (Use stringLinkStream to get it as [String])
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
        // Do something (navigation, ...)
      debugPrint("AppLink Stream ${uri.toString()}");
      openAppLink(uri);
    });
  }

  Future<void> _initPackageInfo() async {
    if (_hasSetupPackageInfo || kIsWeb) return;
    _hasSetupPackageInfo = true;
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final firebaseService = Get.find<FirebaseService>();

    FirebaseAnalytics.instance.setDefaultEventParameters({
      "appVersion": packageInfo.version
    });
    final context = Get.context;
    if (context == null) return;
    if (firebaseService.softUpdate.isNotEmpty &&
        firebaseService.forceUpdate.isNotEmpty) {
      final currentVersion =
          Version.parse(packageInfo.version.replaceAll("-dev", ""));
      final softUpdateVersion = Version.parse(firebaseService.softUpdate);
      final forceUpdateVersion = Version.parse(firebaseService.forceUpdate);

      if (forceUpdateVersion > currentVersion) {
        // ignore: use_build_context_synchronously
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return PopScope(
                  canPop: false,
                  child: AlertDialog(
                    title: const Text("Update your app"),
                    content: const Text(
                        "To always use UFO Elektronika, you need to update your app"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            StoreRedirect.redirect(
                                iOSAppId: FlavorConfig.instance.values.iosAppId,
                                androidAppId: packageInfo.packageName);
                          },
                          child: const Text("Update now"))
                    ],
                  ));
            });
      } else if (softUpdateVersion > currentVersion) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text("You can update your app"),
                content: const Text(
                    "Update your app to make your experience better"),
                actions: [
                  TextButton(
                      onPressed: () {
                        StoreRedirect.redirect(
                            iOSAppId: FlavorConfig.instance.values.iosAppId,
                            androidAppId: packageInfo.packageName);
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text("Update now")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text("Update later")),
                ],
              );
            });
      }
    }
  }

  void openAppLink(Uri uri) {
      if (uri.scheme.contains("http")) {
        Get.toNamed(uri.toString(), preventDuplicates: false);
        // Fluttertoast.showToast(
        //   msg: "AppLink Stream ${uri.path}",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.blue,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
      } else {
        Get.toNamed(uri.path, parameters: uri.queryParameters, preventDuplicates: false);
        // Fluttertoast.showToast(
        //   msg: "AppLink Stream ${uri.path}",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.blue,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
      }
  }

  void initMidtrans() async {
    final primaryColor = Theme.of(context).primaryColor;
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final sdk = await MidtransSDK.init(config: MidtransConfig(
      clientKey: FlavorConfig.instance.values.midtransClientKey,
      merchantBaseUrl: FlavorConfig.instance.values.midtransMerchantBaseUrl,
      colorTheme: ColorTheme(
        colorPrimary: primaryColor,
        colorPrimaryDark: primaryColorDark,
        colorSecondary: primaryColor,
      ),
    ));
    sdk.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    sdk.printError();

    _midtransProvider.getMidtransSDK = () => sdk;
  }

  Dio initDio() {
    final dio = Dio(BaseOptions(
        baseUrl: FlavorConfig.instance.values.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => (status ?? 0) < 500 && (status ?? 0) != 401 && (status ?? 0) != 404
      ),
    );

    // dio.interceptors.add(SessionInterceptor());

    void initHeaderInterceptor(Dio dio) async {
      final packageInfo = await PackageInfo.fromPlatform();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceId = Platform.isAndroid ? (await deviceInfoPlugin.androidInfo).id : Platform.isIOS ? (await deviceInfoPlugin.iosInfo).identifierForVendor : throw Exception();
      
      dio.interceptors.add(HeaderInterceptor(
        packageInfo: packageInfo,
        deviceId: deviceId,
        contextGetter: () => Get.context,
        fcmTokenGetter: firebaseService.fcmTokenGetter
      ));
    }
    initHeaderInterceptor(dio);

    getApplicationDocumentsDirectory().then((appDocDir) {
      final String appDocPath = appDocDir.path;
      final cookieJar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage("$appDocPath/.cookies/"),
      );
      final cookieManager = CookieManager(cookieJar);
      
      dio.interceptors.add(cookieManager);
    });
    dio.interceptors.add(AuthorizationInterceptor(
      secureStorage: const FlutterSecureStorage(),
      onUnauthorized: () {
        Get.find<MainController>().unauthorized();
      }
    ));

    dio.interceptors.add(CrashlyticInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }

  @override
  Widget build(BuildContext context) {
    final dio = initDio();
    final cartProvider = CartProvider(repository: CartRepositoryImpl(dio: dio));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => cartProvider)
      ],
      child: Sizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            onUnknownRoute: (settings) {
              return GetPageRoute(
                routeName: WebViewScreen.routeName,
                page: () => WebViewScreen(url: settings.name ?? "/"), binding: WebViewBinding()
              );
            },
            smartManagement: SmartManagement.keepFactory,
            initialBinding: BindingsBuilder(() {
              Get.lazyPut(() => routeObserver);
              Get.lazyPut(() => firebaseService);
              Get.lazyPut<Dio>(() => dio);
              Get.lazyPut(() => const FlutterSecureStorage());
              Get.lazyPut(() => WebviewController());

              Get.lazyPut(() => MainController(secureStorage: Get.find(), firebaseAnalytics: firebaseService.firebaseAnalytics, firebaseCrashlytics: firebaseService.firebaseCrashlytics));

              Get.lazyPut<WishlistRepository>(() => WishlistRepositoryImpl(dio: dio));
              Get.lazyPut(() => WishlistController(repository: Get.find(), secureStorage: Get.find()));

              Get.lazyPut<CartRepository>(() => CartRepositoryImpl(dio: dio));
              Get.lazyPut(() => CartController(repository: Get.find(), voucherRepository: VoucherRepositoryImpl(dio: Get.find()), wishlistController: Get.find(), secureStorage: Get.find()));
            }),
            onGenerateRoute: (settings) {
              final uri = Uri.parse(settings.name!);
              final path = uri.path;
              final parameters = uri.queryParameters;
              firebaseService.firebaseAnalytics.logScreenView(screenClass: settings.name, screenName: path, parameters: uri.queryParameters);

              if (path.startsWith(SplashScreen.routeName) == true) {
                return GetPageRoute(routeName: SplashScreen.routeName, page: () => const SplashScreen());
              }
              if (path.startsWith(MainScreen.routeName) == true) {
                if (firebaseService.isInitialized) {
                  _initPackageInfo();
                }

                // We need to init applink here and delayed it to ensure user has landed to home
                Future.delayed(const Duration(milliseconds: 800), () {
                  initAppLinks();
                });

                return GetPageRoute(routeName: MainScreen.routeName, page: () => const MainScreen(), bindings: [
                  HomeBinding(), 
                  MainMenuBinding(), 
                  MainBinding(), 
                  TransactionBinding(),              
                  BindingsBuilder.put(() => _midtransProvider),
                  NewsBinding(), 
                  AccountBinding()]
                );
              }
              if (path.startsWith(ProductScreen.routeName) == true) {
                final id = parameters["id"];
                if (id != null) {
                  final bindingIdentifier = "${Random().nextDouble()}";
                  return GetPageRoute(
                    routeName: ProductScreen.routeName, 
                    page: () => ProductScreen(productId: id, bindingIdentifier: bindingIdentifier,), 
                    binding: ProductBinding(productId: id, bindingIdentifier: bindingIdentifier)
                  );
                }
              }

              if (path.startsWith(CompareProductScreen.routeName) == true) {
                return GetPageRoute(routeName: CompareProductScreen.routeName, page: () => const CompareProductScreen(), binding: CompareProductBinding());
              }

              if (path.startsWith(SearchResultScreen.routeName) == true) {
                final keyword = parameters["keyword"];
                if (keyword != null) {
                  return GetPageRoute(routeName: SearchResultScreen.routeName, page: () => SearchResultScreen(keyword: keyword), binding: SearchResultBinding(keyword: keyword));
                }
              }

              if (path.startsWith(FindOrderScreen.routeName) == true) {
                return GetPageRoute(routeName: FindOrderScreen.routeName, page: () => const FindOrderScreen());
              }
              if (path.startsWith(MainMenuScreen.routeName) == true) {
                return GetPageRoute(routeName: MainMenuScreen.routeName, page: () => const MainMenuScreen(), binding: MainMenuBinding());
              }
              if (path.startsWith(LoginScreen.routeName) == true) {
                return GetPageRoute(routeName: LoginScreen.routeName, page: () => const LoginScreen(), bindings: [LoginBinding(), BindingsBuilder.put(() => firebaseService)]);
              }
              
              if (path.startsWith(ForgotPasswordScreen.routeName) == true) {
                return GetPageRoute(routeName: ForgotPasswordScreen.routeName, page: () => const ForgotPasswordScreen(), bindings: [ForgotPasswordBinding()]);
              }
              
              if (path.startsWith(RegisterScreen.routeName) == true) {
                return GetPageRoute(routeName: RegisterScreen.routeName, page: () => const RegisterScreen(), bindings: [RegisterBinding(), BindingsBuilder.put(() => firebaseService)]);
              }

              if (path.startsWith(CategoryScreen.routeName) == true) {
                final id = parameters["id"];
                final type = parameters["type"];
                if (id != null || type != null) {
                  return GetPageRoute(routeName: CategoryScreen.routeName, page: () => CategoryScreen(id: id, type: type), bindings: [CategoryBinding()]);
                }
              }

              if (path.startsWith(InformationScreen.routeName) == true) {
                final id = parameters["id"];
                if (id != null) {
                  return GetPageRoute(routeName: InformationScreen.routeName, page: () => const InformationScreen(), bindings: [InformationBinding(id: id, notificationId: null)]);
                }
                final notifId = parameters["notification_id"];
                if (notifId != null) {
                  return GetPageRoute(routeName: InformationScreen.routeName, page: () => const InformationScreen(), bindings: [InformationBinding(id: null, notificationId: notifId)]);
                }
              }

              if (path.startsWith(AccountScreen.routeName) == true) {
                return GetPageRoute(routeName: AccountScreen.routeName, page: () => const AccountScreen());
              }

              if (path.startsWith(AddressScreen.routeName) == true) {
                return GetPageRoute(routeName: AddressScreen.routeName, page: () => const AddressScreen(), binding: AddressBinding());
              }

              if (path.startsWith(AddressAddUpdateScreen.routeName) == true) {
                final id = parameters["id"];
                return GetPageRoute(routeName: AddressAddUpdateScreen.routeName, page: () => AddressAddUpdateScreen(addressId: id), binding: AddressAddUpdateBinding());
              }

              if (path.startsWith(TransactionDetailScreen.routeName) == true) {
                final id = parameters["id"];
                if (id != null) {
                  return GetPageRoute(routeName: TransactionDetailScreen.routeName, page: () => TransactionDetailScreen(orderId: id), binding: TransactionDetailBinding());
                }
              }

              if (path.startsWith(TransactionScreen.routeName) == true) {
                if (Get.find<MainController>().currentUser.value == null) {
                  return GetPageRoute(routeName: LoginScreen.routeName, page: () => const LoginScreen(), bindings: [LoginBinding()]);
                }
                final tag = Random().nextInt(10000000).toString();
                return GetPageRoute(
                  routeName: TransactionScreen.routeName, 
                  page: () => TransactionScreen(tag: tag), 
                  bindings: [
                    TransactionBinding(tag: tag),
                    BindingsBuilder.put(() => _midtransProvider)
                  ]
                );
              }

              if (path.startsWith(WishlistScreen.routeName) == true) {
                return GetPageRoute(routeName: WishlistScreen.routeName, page: () => const WishlistScreen(), binding: WishlistBinding());
              }

              if (path.startsWith(UserUpdateScreen.routeName) == true) {
                return GetPageRoute(routeName: UserUpdateScreen.routeName, page: () => const UserUpdateScreen(), binding: UserUpdateBinding());
              }

              if (path.startsWith(ChangePasswordScreen.routeName) == true) {
                final email = parameters["email"];
                if (email != null) {
                  return GetPageRoute(routeName: ChangePasswordScreen.routeName, page: () => ChangePasswordScreen(email: email));
                }
              }

              if (path.startsWith(ProductReviewScreen.routeName) == true) {
                return GetPageRoute(routeName: ProductReviewScreen.routeName, page: () => const ProductReviewScreen());
              }

              if (path.startsWith(WebViewScreen.routeName) == true) {
                final url = parameters["url"];
                final title = parameters["title"];
                return GetPageRoute(routeName: WebViewScreen.routeName, page: () => WebViewScreen(url: url ?? "/", title: title,), binding: WebViewBinding());
              }

              if (path.startsWith(LiveChatScreen.routeName) == true) {
                return GetPageRoute(routeName: LiveChatScreen.routeName, page: () => LiveChatScreen());
              }

              if (path.startsWith(BrandScreen.routeName) == true) {
                return GetPageRoute(routeName: BrandScreen.routeName, page: () => const BrandScreen());
              }

              if (path.startsWith(UfopointScreen.routeName) == true) {
                return GetPageRoute(routeName: UfopointScreen.routeName, page: () => const UfopointScreen(), binding: UfoPointBinding());
              }

              if (path.startsWith(VoucherScreen.routeName) == true) {
                if (Get.find<MainController>().currentUser.value == null) {
                  return GetPageRoute(routeName: LoginScreen.routeName, page: () => const LoginScreen(), bindings: [LoginBinding()]);
                }
                final paymentMethod = parameters["paymentMethod"];
                return GetPageRoute(routeName: VoucherScreen.routeName, page: () => VoucherScreen(source: VoucherClaimSource.user, paymentMethod: paymentMethod), binding: VoucherBinding());
              }

              if (path.startsWith(NotificationScreen.routeName) == true) {
                return GetPageRoute(routeName: NotificationScreen.routeName, page: () => const NotificationScreen(), binding: NotificationBinding());
              }

              if (path.startsWith(MyReviewsScreen.routeName) == true) {
                final transactionControllerTag = Random().nextInt(10000000).toString();
                return GetPageRoute(routeName: MyReviewsScreen.routeName, page: () => MyReviewsScreen(transactionControllerTag: transactionControllerTag), binding: MyReviewsBinding(transactionControllerTag: transactionControllerTag));
              }

              if (path.startsWith(RefundScreen.routeName) == true) {
                final orderId = parameters["order_id"];
                if (orderId != null) {
                  return GetPageRoute(routeName: RefundScreen.routeName, page: () => const RefundScreen(), binding: RefundBinding(orderId: orderId));
                }
              }

              if (path.startsWith(CartScreen.routeName) == true) {
                return GetPageRoute(routeName: CartScreen.routeName, page: () => const CartScreen(), bindings: [RecommendationBinding()]);
              }

              if (path.startsWith(CheckoutScreen.routeName) == true) {
                return GetPageRoute(
                  routeName: CheckoutScreen.routeName, 
                  page: () => const CheckoutScreen(), 
                  bindings: [
                    BindingsBuilder.put(() => _midtransProvider),
                    CheckoutBinding()
                  ]
                );
              }

              if (path.startsWith(CheckoutPaymentManualConfirmationScreen.routeName) == true) {
                final redirectionUrl = parameters["redirection_url"];
                if (redirectionUrl != null) {
                  return GetPageRoute(
                    routeName: CheckoutPaymentManualConfirmationScreen.routeName, 
                    page: () => const CheckoutPaymentManualConfirmationScreen(),
                    binding: CheckoutPaymentManualBinding(redirectionUrl: redirectionUrl)
                  );
                }
              }

              if (path.startsWith(PaymentMethodScreen.routeName) == true) {
                return GetPageRoute(routeName: PaymentMethodScreen.routeName, page: () => const PaymentMethodScreen());
              }

              if (path.startsWith(CheckoutProcessingScreen.routeName) == true) {
                return GetPageRoute(routeName: CheckoutProcessingScreen.routeName, page: () => const CheckoutProcessingScreen());
              }

              if (path.startsWith(CheckoutSuccessScreen.routeName) == true) {
                return GetPageRoute(routeName: CheckoutSuccessScreen.routeName, page: () => const CheckoutSuccessScreen());
              }
              // For Facebook story redirection after sharing
              if (path.startsWith("/camera") == true) {
                return GetPageRoute(routeName: "camera", page: () => Scaffold(
                  appBar: const UEAppBar(title: "Camera", showCart: false, showNotification: false),
                  body: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text(parameters.toString()),
                    ),
                  ),
                ));
              }
              return null;
            },
            theme: AppTheme.defaultTheme,
          );
        }
      )
    );
  }
}