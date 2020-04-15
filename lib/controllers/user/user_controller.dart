import 'package:dart_week_api/controllers/user/dto/signup_user_request.dart';
import 'package:dart_week_api/services/user_service.dart';

import '../../dart_week_api.dart';

class UserController extends ResourceController {
  UserController(this.context) : userService = UserService(context);

  final ManagedContext context;
  final UserService userService;

  @Operation.post()
  Future<Response> save(@Bind.body() SignUpUserRequest request) async {
    final validate = request.validate();
    if (validate.isNotEmpty) {
      return Response.badRequest(body: validate);
    }

    try {
      await userService.saveUser(request);
      return Response.ok({'message': 'Usuário cadastrado com sucesso!'});
    } catch (e) {
      print(e);
      return Response.serverError(
          body: {'message': 'Erro ao salvar usuário!', 'ex': e.toString()});
    }
  }
}
