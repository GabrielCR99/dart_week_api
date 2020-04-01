import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/user_model.dart';

class UserRepository {
  UserRepository(this.context);
  final ManagedContext context;

  Future<UserModel> recoverUserByPasswordAndEmail(
      String login, String password) {
    final query = Query<UserModel>(context)
      ..where((user) => user.login).equalTo(login)
      ..where((user) => user.password).equalTo(password);

    return query.fetchOne();
  }
}
