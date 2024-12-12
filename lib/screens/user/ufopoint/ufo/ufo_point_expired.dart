import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_controller.dart';

class UfoPointExpired extends StatelessWidget {
  final UfoPointController controller;
  const UfoPointExpired({super.key, required this.controller});

  static List histories = [
    {
      'date': '15 Jun 2023',
      'description': '10% off',
    },
    {
      'date': '15 Jun 2023',
      'description': '10% off',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            'Akan kadaluwarsa',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE9E9E9),
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Tanggal',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Deskripsi',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Poin',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),

          // list
          if (controller.ufoPoint.value?.pointExpiredHistory.isNotEmpty == true)
            Expanded(
              child: ListView.builder(
                itemCount: controller.ufoPoint.value?.pointExpiredHistory.length,
                itemBuilder: (context, index) {
                  final history = controller.ufoPoint.value?.pointExpiredHistory[index];
                  if (history == null) return Container();
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE9E9E9),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(DateFormat("d MMMM yyyy").format(history.dateAdded ?? DateTime.now())),
                        ),
                        Expanded(
                          child: Text(history.description ?? ""),
                        ),
                        Expanded(
                          child: Text(history.points ?? ""),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
        ],
      ),
    ));
  }
}
