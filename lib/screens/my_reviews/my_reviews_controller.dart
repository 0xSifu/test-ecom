import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/my_reviews/my_reviews_repository.dart';
import 'package:ufo_elektronika/screens/transaction/transaction_repository.dart';

class MyReviewsController extends GetxController {

  final MyReviewsRepository _repository;
  final TransactionRepository _transactionRepository;
  MyReviewsController({
    required MyReviewsRepository repository, 
    required TransactionRepository transactionRepository
  }): _repository = repository, _transactionRepository = transactionRepository;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    // futurize(_repository.getNews);
  }
}