import 'dart:convert';

import 'package:dart_week_api/controllers/login/dto/login_request.dart';
import 'package:dart_week_api/controllers/user/dto/signup_user_request.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/repository/user_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_week_api/utils/crypt_util.dart';
import 'package:dart_week_api/utils/jwt_utils.dart';

import '../dart_week_api.dart';

class UserService {
  UserService(this.context) : userRepository = UserRepository(context);
  final ManagedContext context;
  final UserRepository userRepository;

  Future<String> login(LoginRequest request) async {
    final String login = request.login;
    final String password = request.password;

    final String cryptoPassword = CryptUtils.cryptPassword(password);
    final user = await userRepository.recoverUserByPasswordAndEmail(
        login, cryptoPassword);
    if (user != null) {
      return JWTUtils.generateJWTToken(user);
    }
    return user?.login;
  }

  Future<void> saveUser(SignUpUserRequest request) async {
    await userRepository.saveUser(request);
  }

  Future<UserModel> searchById(int id) async =>
      await userRepository.searchById(id);
}
