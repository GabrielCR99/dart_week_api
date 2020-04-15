import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/services/category_service.dart';

import '../../dart_week_api.dart';

class CategoriesController extends ResourceController {
  CategoriesController(this.context) : service = CategoryService(context);

  final ManagedContext context;
  final CategoryService service;

  @Operation.get('type')
  Future<Response> findAllCategoriesByType() async {
    try {
      final type = request.path.variables['type'];

      final categoryType = CategoryType.values
          .firstWhere((t) => t.toString().split('.').last == type);

      return service
          .searchCategoryByType(categoryType)
          .then((res) => res.map((c) => {'id': c.id, 'name': c.name}).toList())
          .then((data) => Response.ok(data));
    } catch (e) {
      print(e);
      return Response.serverError(body: {'message': e.toString()});
    }
  }
}
