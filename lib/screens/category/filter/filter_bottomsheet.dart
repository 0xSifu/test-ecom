import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/buttons.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/models/product_filter.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/category/category_response.dart';
import 'package:ufo_elektronika/screens/category/filter/filter_controller.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';

class FilterBottomSheet extends GetView<FilterController> {
  final CategoryParam param;
  final List<CategoryFiltersList> otherFilters;
  final double? maxPrice;
  const FilterBottomSheet({super.key, required this.param, required this.otherFilters, required this.maxPrice});

  @override
  Widget build(BuildContext context) {
    // thousand format for price
    Intl.defaultLocale = 'in_ID';
    var thousandFormat = NumberFormat('#,###');

    // // price filter settings
    double minPrice = 0;
    double maxPrice = ((this.maxPrice ?? 100000000.0) / 1000000.0).ceilToDouble() * 1000000;
    controller.loadWith(param: param);

    return ModalBottomSheetDefault(
      title: "Filter",
      initialChildSize: 0.9,
      child: (scrollController) => Obx(() {
        if (!controller.hasSetupBrandTextFieldFocusNode) {
          controller.hasSetupBrandTextFieldFocusNode = true;
          controller.brandTextFieldFocusNode.addListener(() {
            if (controller.brandTextFieldFocusNode.hasFocus) {
              Future.delayed(const Duration(milliseconds: 1000), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent - 50);
              });
            }
          });
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* ------------------------------ button filter ----------------------------- */
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: Sort.values.map((e) => SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                controller.sortBy(e);
                              },
                              style: controller.param.value.sort != e
                                  ? AppButton.outlineGray
                                  : AppButton.outlineGrayActive,
                              child: Text(e.buttonText),
                            ),
                          )).toList()
                        ),
                        const SizedBox(height: 30),

                        /* ---------------------------------- price --------------------------------- */
                        Text(
                          'Harga',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        RangeSlider(
                          values: RangeValues(controller.param.value.minPrice ?? minPrice,
                              controller.param.value.maxPrice ?? maxPrice),
                          min: minPrice,
                          max: maxPrice,
                          divisions: 100,
                          activeColor: AppColor.primaryColor,
                          onChanged: controller.changeMinAndMaxPrice,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Rp${thousandFormat.format(controller.param.value.minPrice ?? minPrice)}'),
                            Text(
                                'Rp${thousandFormat.format(controller.param.value.maxPrice ?? maxPrice)}'),
                          ],
                        ),
                        const SizedBox(height: 30),

                        /* ----------------------------- filter brands ---------------------------- */
                        if (controller.brands.isNotEmpty || controller.filterKeyword.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brand',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 10),

                            // selected brands
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var selectedBrand in controller.param.value.brands ?? <ProductFilter>[])
                                      Container(
                                        margin: const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grayBorder),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(selectedBrand.name),
                                            IconButton(
                                              onPressed: () {
                                                controller.removeBrand(selectedBrand);
                                              },
                                              icon: const Icon(Icons.cancel),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),

                            // search brands
                            TextField(
                              controller: controller.searchBrandController,
                              onChanged: (value) {
                                controller.filterKeyword.value = value;
                              },
                              focusNode: controller.brandTextFieldFocusNode,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Cari Brand',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFB6B6B6)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFB6B6B6)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                suffixIcon: controller.searchBrandController.text.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(
                                            Icons.cancel), // clear text
                                        onPressed: () {
                                          controller.searchBrandController.clear();
                                          controller.filterKeyword.value = "";
                                        },
                                      ),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 5),

                            // brands list
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: controller.brands.map((brand) => SizedBox(
                                height: 30,
                                child: CheckboxListTile(
                                  dense: true,
                                  value: controller.param.value.brands?.contains(brand) == true,
                                  onChanged: (value) {
                                    if (value == true) {
                                      controller.addBrand(brand);
                                    } else if (value == false) {
                                      controller.removeBrand(brand);
                                    }
                                  },
                                  title: Text(
                                    brand.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              )).toList(),
                            ),

                            // show more brands
                            TextButton(
                              onPressed: () {
                                if (controller.isShowingAllBrands.value == true) {
                                  controller.showLessBrand();
                                } else {
                                  controller.showMoreBrand();
                                }
                              },
                              child: Row(
                                children: [
                                  Text(controller.isShowingAllBrands.value == true ? "Lebih Sedikit" : 'Lainnya',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColor.primaryColor,
                                        ),
                                  ),
                                  Icon(
                                    controller.isShowingAllBrands.value == true ? Icons.expand_less : Icons.expand_more,
                                    color: AppColor.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        
                        for (var filterGroup in otherFilters)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filterGroup.groupName ?? ""),

                              for (var filter in ( filterGroup.detail.take(controller.isShowingOtherFilter[filterGroup] == true ? filterGroup.detail.length : 5)))
                                SizedBox(
                                  height: 30,
                                  child: CheckboxListTile(
                                    value: controller.param.value.filters?.firstWhereOrNull((e) => e.filterId == filter.filterId) != null,
                                    onChanged: (value) {
                                      if (value == true) {
                                        controller.addFilter(filter);
                                      } else if (value == false) {
                                        controller.removeFilter(filter);
                                      }
                                    },
                                    title: Text(
                                      filter.name ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding: const EdgeInsets.all(0),
                                  ),
                                ),
                              // show more brands
                              TextButton(
                                onPressed: () {
                                  if (controller.isShowingOtherFilter[filterGroup] == true) {
                                    controller.isShowingOtherFilter[filterGroup] = false;
                                  } else {
                                    controller.isShowingOtherFilter[filterGroup] = true;
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(controller.isShowingOtherFilter[filterGroup] == true ? "Lebih Sedikit" : 'Lainnya',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: AppColor.primaryColor,
                                          ),
                                    ),
                                    Icon(
                                      controller.isShowingOtherFilter[filterGroup] == true ? Icons.expand_less : Icons.expand_more,
                                      color: AppColor.primaryColor,
                                    ),
                                  ],
                                ),
                            ),
                              const SizedBox(height: 20),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  color: Colors.white,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context, controller.param.value);
                    },
                    child: const Text('Tampilkan'),
                  ),
                ),
                const SizedBox(height: 7),
                SafeArea(child: Container(
                  width: double.infinity,
                  height: 48,
                  color: Colors.white,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.reset();
                    },
                    child: const Text('Reset'),
                  ),
                )),
              ],
            ),
          ),
        );
      }),
    );
    
  }
}