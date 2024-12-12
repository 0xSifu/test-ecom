import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufo/ufo_point_active.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufo/ufo_point_expired.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufo/ufo_point_history.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_controller.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';

class UfopointScreen extends GetView<UfoPointController> {
  static const routeName = "/ufopoint";
  const UfopointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const UEAppBar(
          title: 'UFO POIN',
          showCart: false,
          showNotification: false,
          preferredSize: Size.fromHeight(82),
          bottom: TabBar(
            labelPadding: EdgeInsets.all(0),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text('Aktif'),
              ),
              Tab(
                child: Text('Riwayat'),
              ),
              Tab(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    'Akan Kadaluwarsa',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() => TabBarView(
          children: [
            // Text("Hahahaha 1"),
            UfoPointActive(controller: controller, response: controller.ufoPoint.value),
            // Text("Hahahaha 2"),
            UfoPointHistory(controller: controller),
            // Text("Hahahaha 3"),
            UfoPointExpired(controller: controller),
          ],
        )),
      ),
    );
  }
}
