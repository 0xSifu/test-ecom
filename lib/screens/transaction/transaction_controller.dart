import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_statuses_response.dart';
import 'package:ufo_elektronika/screens/transaction/transactions_response.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TransactionController extends GetxController with GetTickerProviderStateMixin {
  final TransactionRepository _repository;
  TransactionController({required TransactionRepository repository}): _repository = repository;

  final tabController = Rx<TabController?>(null);
  final selectedOrderStatus = Rx<TransactionStatus>(TransactionStatus.unknown);
  final isLoadingStatuses = false.obs;
  final transactionStatuses = RxList<TransactionStatusesResponse>([]);
  final ItemScrollController transactionListItemScrollController = ItemScrollController();
  final ItemPositionsListener transactionListItemPositionsController = ItemPositionsListener.create();
  
  final ordersPerStatus = RxMap<TransactionStatus, List<Order>?>();
  final pagesPerStatus = RxMap<TransactionStatus, int?>();

  final isLoadingOrders = true.obs;
  final periods = RxList<String>([]);
  final searchKeyword = "".obs;
  final selectedPeriod = "".obs;
  final isClickAndCollectOn = false.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    isLoadingStatuses.value = true;
    _repository.getTransactionStatuses()
      .then((value) {
        isLoadingStatuses.value = false;
        transactionStatuses.assignAll(value);
        transactionStatuses.insert(0, TransactionStatusesResponse(orderStatusId: TransactionStatus.unknown, languageId: null, name: "Semua"));

        ordersPerStatus.value = { for (var element in transactionStatuses) element.orderStatusId : null };
        pagesPerStatus.value = { for (var element in transactionStatuses) element.orderStatusId : 1 };
        load();
        
        final tabController = TabController(length: transactionStatuses.length, vsync: this);
        tabController.addListener(() {
          final selectedIndex = transactionStatuses.indexWhere((r) => r.orderStatusId == selectedOrderStatus.value);
          if (tabController.index != selectedIndex) {
            selectedOrderStatus.value = transactionStatuses[tabController.index].orderStatusId;
            
            final selectedTabPosition = transactionListItemPositionsController.itemPositions.value
              .firstWhereOrNull((itemPosition) => itemPosition.index == selectedIndex);

            // 0 <------ inside viewport ------> 1
            if (selectedTabPosition != null && (selectedTabPosition.itemLeadingEdge < 0 || selectedTabPosition.itemTrailingEdge > 1)) {
                transactionListItemScrollController.scrollTo(
                  index: selectedIndex, 
                  alignment: selectedTabPosition.itemLeadingEdge < 0 ? -selectedTabPosition.itemLeadingEdge : -(selectedTabPosition.itemTrailingEdge - 1.4),
                  duration: const Duration(milliseconds: 300)
                );

              }

            
          }
        });
        this.tabController.value = tabController;
      })
      .catchError((error) {
        isLoadingStatuses.value = false;
        
      });

    searchKeyword.listen((keyword) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 400), () {
        refreshTransactions();
      });
    });
    isClickAndCollectOn.listen((period) {
      refreshTransactions();
    });
    selectedPeriod.listen((period) {
      refreshTransactions();
    });
    selectedOrderStatus.listen((status) {
      refreshTransactions();
    });
  }

  void refreshTransactions() {
    pagesPerStatus.value = { for (var element in transactionStatuses) element.orderStatusId : 1 };
    load(showLoading: false);
  }

  void loadMore() {
    load();
  }

  void load({bool showLoading = true}) {
    final currentPage = pagesPerStatus[selectedOrderStatus.value];
    if (currentPage == null) return; // Means we reach end of page
    // isLoadingOrders.value = currentPage == 1 && (showLoading || allOrders.isEmpty);
    _repository.getTransactions(
      page: currentPage, 
      search: searchKeyword.value, 
      periode: selectedPeriod.value, 
      orderStatus: selectedOrderStatus.value.rawValue,
      isClickAndCollectOn: isClickAndCollectOn.value
    )
      .then((value) {
        final allOrders = ordersPerStatus[selectedOrderStatus.value] ?? [];
        if (currentPage == 1) {
          allOrders.clear();
        }
        if (value.orders.isEmpty) {
          pagesPerStatus[selectedOrderStatus.value] = null;
        } else {
          pagesPerStatus[selectedOrderStatus.value] = currentPage + 1;
        }
        for (var order in value.orders) {
          if (allOrders.firstWhereOrNull((element) => element.orderId == order.orderId) == null) {
            allOrders.add(order);
          }
        }
        ordersPerStatus[selectedOrderStatus.value] = allOrders;
        periods.assignAll([""] + value.options.reversed.toList());
        isLoadingOrders.value = false;
      })
      .catchError((error) {
        isLoadingOrders.value = false;
      });
  }

  Future<void> uploadPaymentProof(String orderId, String accountName, File image) async {
   return _repository.uploadPaymentProof(orderId, accountName, image)
      .then((value) {
        Get.showSnackbar(const GetSnackBar(
          message: "Berhasil mengupload bukti pembayaran",
          duration: Duration(seconds: 3),
        ));
      })
      .catchError((error) {
        Get.showSnackbar(const GetSnackBar(
          message: "Gagal mengupload bukti pembayaran. Silakan coba lagi.",
          duration: Duration(seconds: 3),
        ));
      });
  }

}