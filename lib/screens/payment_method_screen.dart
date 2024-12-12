import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/widgets/appbar/appbar.dart';
import 'package:ufo_elektronika/widgets/image.dart';
import 'package:ufo_elektronika/widgets/layouts/default_layout.dart';

class PaymentMethodScreen extends StatefulWidget {
  static const routeName = "/payment-method";
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List collapsePanel = [];
  int? collapseId;
  int? selectedPayment;
  int? selectedBank;

  List paymentChannel = [
    {
      'id': 1,
      'name': 'Transfer Bank',
      'banks': [
        {
          'id': 1,
          'name': 'Bank BCA',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-bca.png',
        },
        {
          'id': 2,
          'name': 'Bank BRI',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-bri.png',
        },
        {
          'id': 3,
          'name': 'Bank Mandiri',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-mandiri.png',
        },
        {
          'id': 4,
          'name': 'Bank BNI',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-bni.png',
        },
      ],
    },
    {
      'id': 2,
      'name': 'Credit Card',
      'banks': [
        {
          'id': 5,
          'name': 'Credit Card',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-mastersecure.png',
        },
      ],
    },
    {
      'id': 3,
      'name': 'Virtual Account',
      'banks': [
        {
          'id': 6,
          'name': 'Virtual Account BCA',
          'thumbnail':
              'https://www.ufoelektronika.com/catalog/view/theme/default/image/footer/logo-bca.png',
        },
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UEAppBar(
        showCart: false,
        showNotification: false,
        title: 'Metode Pembayaran',
      ),
      body: DefaultLayout(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (Map<String, dynamic> payment in paymentChannel)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColor.grayBorderBottom,
                      ),
                    ),
                  ),
                  child: ExpansionPanelList(
                    elevation: 0,
                    expandedHeaderPadding: const EdgeInsets.all(0),
                    expansionCallback: (panelIndex, isExpanded) => setState(() {
                      if (collapsePanel.contains(payment['id'])) {
                        collapsePanel.remove(payment['id']);
                      } else {
                        collapsePanel.add(payment['id']);
                      }
                    }),
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: collapsePanel.contains(payment['id'])
                            ? true
                            : false,
                        backgroundColor: Colors.white,
                        headerBuilder: (context, isExpanded) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  payment['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                if (selectedPayment == payment['id'])
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor
                                          .primaryColor, // Color of the circular container
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        body: Column(
                          children: [
                            for (Map<String, dynamic> bank in payment['banks'])
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPayment = payment['id'];
                                    selectedBank = bank['id'];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 25,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColor.grayBorderBottom,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: UEImage2(
                                                  bank['thumbnail']),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(bank['name']),
                                          ],
                                        ),
                                        if (selectedBank == bank['id'])
                                          const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: AppColor.primaryColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: SizedBox(
          height: 48,
          child: FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Konfirmasi'),
          ),
        ),
      ),
    );
  }
}
