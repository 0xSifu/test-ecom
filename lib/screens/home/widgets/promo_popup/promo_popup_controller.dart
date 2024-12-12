import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:ufo_elektronika/screens/home/entities/super_deal_response.dart';
import 'package:ufo_elektronika/screens/home/repositories/home_repository.dart';
import 'package:ufo_elektronika/widgets/image.dart';

class PromoPopupController extends GetxController {
  final HomeRepository _repository;
  PromoPopupController({required HomeRepository repository}): _repository = repository;

  var popup = Rx<PopUpResponse?>(null);
  var hasShown = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    ever(popup, (value) {
      if (value == null || hasShown.value == true) return;
      hasShown.value = true;
      bool hasFinishedDownloadImage = false;
      Get.generalDialog(
        barrierDismissible: true,
        barrierLabel: "",
        pageBuilder: (context, animation, secondaryAnimation) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Stack(
                children: [
                  // promo image
                  GestureDetector(
                    onTap: () {
                      final link = popup.value?.popup?.link ?? "";
                      if (link.isNotEmpty) Get.toNamed(link);
                    },
                    child: UEImage2(value.popup?.image ?? "", showShimmer: false, width: sizer.Device.screenType == sizer.ScreenType.tablet ? 50.w : null, onFinishedProgress: () {

                      Future.delayed(const Duration(milliseconds: 900), () {
                        if (context.mounted) {
                          setState(() {
                            hasFinishedDownloadImage = true;
                          });
                        }
                      });
                    }),
                  ),

                  // close button
                  if (hasFinishedDownloadImage)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
        }
      );
    });

    if (popup.value == null) {
      _repository.loadPopup().then((value) {
        popup.value = value;
      });
    }
  }
}