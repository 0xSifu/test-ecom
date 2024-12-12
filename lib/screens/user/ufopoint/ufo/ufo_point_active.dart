import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_controller.dart';
import 'package:ufo_elektronika/screens/user/ufopoint/ufopoint_response.dart';

class UfoPointActive extends StatelessWidget {
  final UfoPointController controller;
  final UfoPointResponse? response;
  const UfoPointActive({super.key, required this.controller, required this.response});

  void claimConfirmation(BuildContext context, Coupon coupon) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Apakah anda ingin klaim voucher ini?'),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Nanti Saja'),
            ),
            FilledButton(
              onPressed: () {
                controller.claim(coupon);
              },
              child: const Text('Klaim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UFO Poin Anda',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(response?.total?.toString() ?? "0",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (response?.coupon.isNotEmpty == true)
            const Text('Tukarkan poin anda dengan voucher dibawah ini'),
          const SizedBox(height: 15),
          /* ------------------------------ voucher list ------------------------------ */
          if (response?.coupon.isNotEmpty == true)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: response?.coupon.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final coupon = response?.coupon[index];
                  if (coupon == null) return Container();
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      border: Border.all(
                        color: AppColor.primaryColor.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(coupon.name ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Minimal Belanja ${coupon.min}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FilledButton(
                                  onPressed: () => claimConfirmation(context, coupon),
                                  child: const Text('Klaim'),
                                ),
                                Text(
                                  '${coupon.point} Poin',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: AppColor.primaryColor.withOpacity(0.3),
                          height: 1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Terpakai ${coupon.usesTotal}'),
                            Text(
                              'S/d ${coupon.end}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
