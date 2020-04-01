import 'package:dart_week_api/dart_week_api.dart';

class LoginRequest extends Serializable {
  String login;
  String password;

  @override
  Map<String, dynamic> asMap() {
    return {'login': login, 'password': password};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    login = object['login'] as String;
    password = object['password'] as String;
  }

  Map<String, String> validate() {
    final Map<String, String> validateResult = {};
    if (login == null || login.isEmpty) {
      validateResult['login'] = 'Login obrigatório!';
    }

    if (password == null || password.isEmpty) {
      validateResult['password'] = 'Senha obrigatório!';
    }

    return validateResult;
  }
}
