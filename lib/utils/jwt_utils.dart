import 'package:dart_week_api/model/user_model.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JWTUtils {
  static const String _jwtPrivateKey = 'saUemzdYiFXdD6tUIB1btyX6AjKqQIvj6QfrbD';
  static String generateJWTToken(UserModel userModel) {
    final claimSet = JwtClaim(
      issuer: 'http://localhost',
      subject: userModel.id.toString(),
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );

    final token = 'Bearer ${issueJwtHS256(claimSet, _jwtPrivateKey)}';

    return token;
  }

  static JwtClaim verifyToken(String token) {
    return verifyJwtHS256Signature(token, _jwtPrivateKey);
  }
}
