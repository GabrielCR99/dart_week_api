import 'package:dart_week_api/controllers/movimentations/dto/save_movimentation_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/movimentation_model.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/repository/movimentations_repository.dart';

class MovimentationsService {
  MovimentationsService(this.context)
      : repository = MovimentationsRepository(context);
  final ManagedContext context;
  final MovimentationsRepository repository;

  Future<List<MovimentationModel>> findMovimentations(
      UserModel user, String yearMonth) {
    return repository.searchMovimentations(user, yearMonth);
  }

  Future<Map<String, dynamic>> recoverTotalMovimentationByType(
      UserModel user, String yearMonth) async {
    final recipes = await repository.recoverTotalYearMonth(
        user, CategoryType.recipe, yearMonth);
    final expenses = await repository.recoverTotalYearMonth(
        user, CategoryType.expense, yearMonth);

    return {
      'recipes': recipes,
      'expenses': expenses,
      'total': (recipes['total'] ?? 0) + (expenses['total'] ?? 0),
      'remainingMoney': (recipes['total'] ?? 0) + (expenses['total'] * -1 ?? 0),
    };
  }

  Future<void> saveMovimentation(
      UserModel user, SaveMovimentationRequest request) async {
    await repository.saveMovimentation(user, request);
  }
}
