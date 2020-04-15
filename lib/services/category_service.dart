import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/repository/category_repository.dart';

class CategoryService {
  CategoryService(this.context) : repository = CategoryRepository(context);

  final ManagedContext context;
  final CategoryRepository repository;

  Future<List<CategoryModel>> searchCategoryByType(CategoryType categoryType) {
    return repository.searchCategoryByType(categoryType);
  }
}
