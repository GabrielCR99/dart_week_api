import 'package:dart_week_api/dart_week_api.dart';

class SaveMovimentationRequest extends Serializable {
  int category;
  DateTime movimentationDate;
  String description;
  double value;

  @override
  Map<String, dynamic> asMap() {
    return {
      'category': category,
      'description': description,
      'movimentationDate': movimentationDate,
      'value': value
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    category = object['category'] as int;
    description = object['description'] as String;
    final movimentationDateString = object['movimentationDate'] as String;
    movimentationDate = movimentationDateString != null
        ? DateTime.parse(movimentationDateString.toString())
        : null;
    value = object['value'] as double;
  }

  Map<String, String> validate() {
    final Map<String, String> validateResult = {};

    if (category == null) {
      validateResult['category'] = 'Categoria não informada!';
    }

    if (value == null) {
      validateResult['value'] = 'Valor não informado!';
    }

    if (movimentationDate == null) {
      validateResult['movimentationDate'] = 'Data não informada!';
    }
    return validateResult;
  }
}
