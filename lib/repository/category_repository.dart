import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';

class CategoryRepository {
  CategoryRepository(this.context);
  final ManagedContext context;

  Future<List<CategoryModel>> searchCategoryByType(CategoryType categoryType) {
    final query = Query<CategoryModel>(context)
      ..where((c) => c.categoryType).equalTo(categoryType);
    return query.fetch();
  }

  Future<CategoryModel> searchById(int id) {
    final query = Query<CategoryModel>(context)..where((c) => c.id).equalTo(id);
    return query.fetchOne();
  }
}
