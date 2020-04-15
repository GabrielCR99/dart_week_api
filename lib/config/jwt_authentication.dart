import 'package:dart_week_api/services/user_service.dart';
import 'package:dart_week_api/utils/jwt_utils.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../dart_week_api.dart';

class JwtAuthentication extends Controller {
  JwtAuthentication(this.context) : service = UserService(context);
  final ManagedContext context;
  final UserService service;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final authHeader = request.raw.headers['authorization'];
    if (authHeader == null || authHeader.isEmpty) {
      return Response.unauthorized();
    }

    final authHeaderContent = authHeader[0]?.split(" ");
    if (authHeaderContent.length != 2 || authHeaderContent[0] != 'Bearer') {
      return Response.badRequest(body: {'message': 'Token inválido!'});
    }
    try {
      final token = authHeaderContent[1];
      final JwtClaim claimSet = JWTUtils.verifyToken(token);
      final userId = int.parse(claimSet.toJson()['sub'].toString());

      if (userId == null) {
        throw JwtException;
      }

      final dateNow = DateTime.now().toUtc();
      if (dateNow.isAfter(claimSet.expiry)) {
        return Response.unauthorized();
      }
      final user = await service.searchById(userId);
      request.attachments['user'] = user;
      return request;
    } on JwtException catch (e) {
      print(e);
      return Response.unauthorized();
    }
  }
}
