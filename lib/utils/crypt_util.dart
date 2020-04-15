import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptUtils {
  static String cryptPassword(String password) {
    final passwordBytes = utf8.encode(password);
    return sha256.convert(passwordBytes).toString();
  }
}
