import 'package:dart_week_api/config/jwt_authentication.dart';
import 'package:dart_week_api/controllers/movimentations/movimentations_controller.dart';
import 'package:dart_week_api/dart_week_api.dart';

class MovimentationRouter {
  static void configure(Router router, ManagedContext context) {
    router
        .route('/movimentations/:yearMonth')
        .link(() => JwtAuthentication(context))
        .link(() => MovimentationsController(context));
    router
        .route('movimentations/total/:totalYearMonth')
        .link(() => JwtAuthentication(context))
        .link(() => MovimentationsController(context));
    router
        .route('movimentations/')
        .link(() => JwtAuthentication(context))
        .link(() => MovimentationsController(context));
  }
}
