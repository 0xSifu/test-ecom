import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/category/category_screen.dart';
import 'package:ufo_elektronika/screens/menu/main_menu_repository.dart';
import 'package:ufo_elektronika/screens/menu/menu_response.dart';

class MainMenuController extends GetxController {
  final MainMenuRepository _repository;
  MainMenuController({required MainMenuRepository repository}): _repository = repository;

  var menus = Rx<MenuResponse?>(null);
  var categoriesStack = RxList<List<Category>>([]);
  var selectedCategory = Rx<Category?>(null);
  List<Category> get currentCategories => categoriesStack.lastOrNull ?? [];
  bool get canGoUp => categoriesStack.length > 1;

  @override
  void onInit() {
    super.onInit();
    _repository.getMenus()
      .then((value) {
        menus.value = value;
        categoriesStack.assign(value.categories);
      })
      .catchError((error) {

      });
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    final nextCategories = category.childLv4 ?? category.childLv3 ?? category.children;
    if (nextCategories.isEmpty) {
      Get.toNamed(CategoryScreen.routeName, parameters: { "id": "${category.categoryId}" });
      return;
    }
    categoriesStack.add([category]);
  }

  void goUp() {
    categoriesStack.removeLast();
  }

  
}