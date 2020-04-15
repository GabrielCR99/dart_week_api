import 'package:dart_week_api/controllers/movimentations/dto/save_movimentation_request.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/movimentation_model.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/repository/category_repository.dart';
import 'package:intl/intl.dart';

class MovimentationsRepository {
  MovimentationsRepository(this.context)
      : categoryRepository = CategoryRepository(context);
  final ManagedContext context;
  final CategoryRepository categoryRepository;

  Future<List<MovimentationModel>> searchMovimentations(
      UserModel model, String yearMonth) {
    final DateFormat dateFormat = DateFormat('yyyy_MM_DD');
    final begin = dateFormat
        .parse('${yearMonth.substring(0, 4)}_${yearMonth.substring(4)}_01');
    final end = dateFormat
        .parse('${yearMonth.substring(0, 4)}_${yearMonth.substring(4)}_31');

    final query = Query<MovimentationModel>(context)
      ..join(object: (m) => m.category)
      ..where((m) => m.user.id).equalTo(model.id)
      ..where((m) => m.movimentationDate).between(begin, end)
      ..sortBy((m) => m.movimentationDate, QuerySortOrder.descending)
      ..sortBy((m) => m.id, QuerySortOrder.descending);

    return query.fetch();
  }

  Future<Map<String, dynamic>> recoverTotalYearMonth(
      UserModel user, CategoryType categoryType, String yearMonth) async {
    final DateFormat dateFormat = DateFormat('yyyy_MM_DD');
    final begin = dateFormat
        .parse('${yearMonth.substring(0, 4)}_${yearMonth.substring(4)}_01');
    final end = dateFormat
        .parse('${yearMonth.substring(0, 4)}_${yearMonth.substring(4)}_31');

    final query = Query<MovimentationModel>(context)
      ..join(object: (m) => m.category)
      ..where((m) => m.user.id).equalTo(user.id)
      ..where((m) => m.movimentationDate).between(begin, end)
      ..where((m) => m.category.categoryType).equalTo(categoryType);
    final List<MovimentationModel> result = await query.fetch();
    final num total = result.fold(0.0, (total, m) => total += m.value);
    return {'type': categoryType.toString(), 'total': total};
  }

  Future<void> saveMovimentation(
      UserModel user, SaveMovimentationRequest request) async {
    final category = await categoryRepository.searchById(request.category);
    final model = MovimentationModel();
    model.category = category;
    model.movimentationDate = request.movimentationDate;
    model.description = request.description;
    model.user = user;
    model.value = request.value;
    await context.insertObject(model);
  }
}
