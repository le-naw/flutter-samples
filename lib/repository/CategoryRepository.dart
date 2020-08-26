import 'package:app_demo/api/ApiProvider.dart';
import 'dart:async';
import 'package:app_demo/models/Categories.dart';

class ChuckCategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<Categories> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return Categories.fromJson(response);
  }
}
