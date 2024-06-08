import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:imperio_task_one_demo/api/api.dart';
import 'package:imperio_task_one_demo/api/api_repository.dart';
import 'package:imperio_task_one_demo/models/category_model.dart';

class HomeScreenController extends GetxController {
  final ApiRepository apiRepository;
  RxInt selectedCategory = 0.obs;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<SubCategory> subCategoryList = <SubCategory>[].obs;

  HomeScreenController({required this.apiRepository});

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  getCategories() async {
    var data = {
      "CategoryId": 0,
      "DeviceManufacturer": "Google",
      "DeviceModel": "Android SDK built for x86",
      "DeviceToken": " ",
      "PageIndex": 1
    };
    categoryList.value = await apiRepository.getCategories(1, data);
    await categoryOnTap(0);
    print(categoryList);
  }

  categoryOnTap(int index) async {
    selectedCategory.value = index;
    var data = {
      "CategoryId": categoryList[index].id,
      "DeviceManufacturer": "Google",
      "DeviceModel": "Android SDK built for x86",
      "DeviceToken": " ",
      "PageIndex": 1
    };
    List<CategoryModel>catList = await apiRepository.getCategories(1, data);
    subCategoryList.value = catList.first.subCategories!;
  }
}
