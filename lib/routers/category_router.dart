import 'package:dart_week_api/config/jwt_authentication.dart';
import 'package:dart_week_api/controllers/categories/categories_controller.dart';
import 'package:dart_week_api/dart_week_api.dart';

class CategoryRouter {
  static void configure(Router router, ManagedContext context) {
    router
        .route('/categories/:type')
        .link(() => JwtAuthentication(context))
        .link(() => CategoriesController(context));
  }
}
