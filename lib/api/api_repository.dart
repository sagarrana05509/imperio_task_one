import 'package:imperio_task_one_demo/models/category_model.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<CategoryModel>> getCategories(
      int page, Map<String, dynamic> data) async {
    try {
      var category = await apiProvider.postMethod(ApiConstants.category, data);
      List list = category["Result"]["Category"];
      List<CategoryModel> modelList =
          list.map((e) => CategoryModel.fromJson(e)).toList();
      return modelList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
