import 'package:dart_week_api/controllers/login/login_controller.dart';
import 'package:dart_week_api/controllers/user/user_controller.dart';
import 'package:dart_week_api/dart_week_api.dart';

class UsersRouter {
  static void configure(Router router, ManagedContext context) {
    router.route('/login').link(() => LoginController(context));
    router.route('/user').link(() => UserController(context));
  }
}
