

class TransactionParam {
  final bool showLoading;
  final int page;
  TransactionParam({
    required this.showLoading,
    required this.page,
  });


  TransactionParam copyWith({
    bool? showLoading,
    int? page,
  }) {
    return TransactionParam(
      showLoading: showLoading ?? this.showLoading,
      page: page ?? this.page,
    );
  }
}