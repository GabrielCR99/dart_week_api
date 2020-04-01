import 'dart:convert';

import 'package:dart_week_api/controllers/login/dto/login_request.dart';
import 'package:dart_week_api/repository/user_repository.dart';
import 'package:crypto/crypto.dart';

import '../dart_week_api.dart';

class UserService {
  UserService(this.context) : userRepository = UserRepository(context);
  final ManagedContext context;
  final UserRepository userRepository;

  Future<String> login(LoginRequest request) async {
    final String login = request.login;
    final String password = request.password;
    final passwordBytes = utf8.encode(password);
    final String cryptoPassword = sha256.convert(passwordBytes).toString();
    final user = await userRepository.recoverUserByPasswordAndEmail(
        login, cryptoPassword);
    print(cryptoPassword);

    return user?.login;
  }
}
