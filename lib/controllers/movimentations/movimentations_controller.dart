import 'package:dart_week_api/controllers/movimentations/dto/save_movimentation_request.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/services/movimentations_service.dart';
import 'package:intl/intl.dart';

import '../../dart_week_api.dart';

class MovimentationsController extends ResourceController {
  MovimentationsController(this.context)
      : service = MovimentationsService(context);

  final ManagedContext context;
  final MovimentationsService service;

  @Operation.get('yearMonth')
  Future<Response> findAllMovimentations() {
    final yearMonth = request.path.variables['yearMonth'];
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final UserModel user = request.attachments['user'] as UserModel;
    return service.findMovimentations(user, yearMonth).then((data) {
      return data
          .map((m) => {
                'id': m.id,
                'movimentationDate': dateFormat.format(m.movimentationDate),
                'description': m.description,
                'value': m.value,
                'category': {
                  'id': m.category.id,
                  'name': m.category.name,
                  'categoryType': m.category.categoryType.toString()
                }
              })
          .toList();
    }).then((list) => Response.ok(list));
  }

  @Operation.get('totalYearMonth')
  Future<Response> recoverTotalYearMonth(
      @Bind.path('totalYearMonth') String yearMonth) async {
    final user = request.attachments['user'] as UserModel;
    final result =
        await service.recoverTotalMovimentationByType(user, yearMonth);
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> saveMovimentation(
      @Bind.body() SaveMovimentationRequest saveRequest) async {
    try {
      final validate = saveRequest.validate();
      if (validate.isNotEmpty) {
        return Response.badRequest(body: validate);
      }

      final user = request.attachments['user'] as UserModel;
      await service.saveMovimentation(user, saveRequest);
      return Response.ok({});
    } catch (e) {
      return Response.serverError(
          body: {'message': 'Erro ao salvar movimentação! $e'});
    }
  }
}
