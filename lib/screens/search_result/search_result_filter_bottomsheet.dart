import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ufo_elektronika/constants/buttons.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'package:ufo_elektronika/screens/category/category_param.dart';
import 'package:ufo_elektronika/screens/search_result/search_result_param.dart';
import 'package:ufo_elektronika/shared/utils/html_unescape/html_unescape.dart';
import 'package:ufo_elektronika/widgets/common/modal_bottom_sheet_default.dart';

class SearchResultFilterBottomsheet extends StatefulWidget {
  final SearchResultParam param;
  const SearchResultFilterBottomsheet({super.key, required this.param});

  @override
  State<SearchResultFilterBottomsheet> createState() => _SearchResultFilterBottomsheetState();
}

class _SearchResultFilterBottomsheetState extends State<SearchResultFilterBottomsheet> {
  late SearchResultParam param;
  bool isShowingAllCategories = false;

  @override
  void initState() {
    super.initState();
    param = widget.param;
  }
  @override
  Widget build(BuildContext context) {
    var thousandFormat = NumberFormat('#,###');
    return ModalBottomSheetDefault(
      title: "Filter",
      initialChildSize: 0.6,
      child: (scrollController) =>Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
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
                              setState(() {
                                param = param.copyWith(sort: e);
                              });
                            },
                            style: param.sort != e
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
                        values: RangeValues(param.minPrice?.toDouble() ?? 0,
                            param.maxPrice?.toDouble() ?? param.maxPriceForFilter?.toDouble() ?? 0),
                        min: 0,
                        max: param.maxPriceForFilter?.toDouble() ?? 0,
                        divisions: 10,
                        activeColor: AppColor.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            param = param.copyWith(minPrice: value.start.toInt(), maxPrice: value.end.toInt());
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Rp${thousandFormat.format(param.minPrice ?? 0)}'),
                          Text(
                              'Rp${thousandFormat.format(param.maxPrice ?? param.maxPriceForFilter?.toDouble() ?? 0)}'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Kategori"),

                          for (var category in ( param.categoriesForFilter.take(isShowingAllCategories ? param.categoriesForFilter.length : 5)))
                            SizedBox(
                              height: 30,
                              child: CheckboxListTile(
                                value: param.categories?.firstWhereOrNull((e) => e.categoryId == category.categoryId) != null,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      param = param.copyWith(categories: (param.categories ?? []) + [category]);
                                    } else if (value == false) {
                                      param = param.copyWith(categories: param.categories?.where((e) => e.categoryId != category.categoryId).toList());
                                    }
                                  });
                                },
                                title: Text(
                                  HtmlUnescape().convert(category.name ?? ""),
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
                              setState(() {
                                isShowingAllCategories = !isShowingAllCategories;
                              });
                            },
                            child: Row(
                              children: [
                                Text(isShowingAllCategories ? "Lebih Sedikit" : 'Lainnya',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppColor.primaryColor,
                                      ),
                                ),
                                Icon(
                                  isShowingAllCategories == true ? Icons.expand_less : Icons.expand_more,
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
                    Navigator.pop(context, param);
                  },
                  child: const Text('Tampilkan'),
                ),
              ),
              const SizedBox(height: 15),
              SafeArea(child: Container(
                width: double.infinity,
                height: 48,
                color: Colors.white,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      param = SearchResultParam(keyword: param.keyword, page: param.page);
                    });
                  },
                  child: const Text('Reset'),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}