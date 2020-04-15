import 'package:dart_week_api/controllers/user/dto/signup_user_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/utils/crypt_util.dart';

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

  Future<void> saveUser(SignUpUserRequest request) async {
    final savedUser = UserModel()..read(request.asMap());
    savedUser.password = CryptUtils.cryptPassword(request.password);

    await context.insertObject(savedUser);
  }

  Future<UserModel> searchById(int id) async {
    final query = Query<UserModel>(context)
      ..where((user) => user.id).equalTo(id);
    return await query.fetchOne();
  }
}
