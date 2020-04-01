import 'package:dart_week_api/model/movimentation_model.dart';

import '../dart_week_api.dart';

class CategoryModel extends ManagedObject<_CategoryModel>
    implements _CategoryModel {}

enum CategoryType { recipe, expense }

@Table(name: 'category')
class _CategoryModel {
  @Column(primaryKey: true)
  int id;

  @Column()
  String name;

  @Column()
  CategoryType categoryType;

  ManagedSet<MovimentationModel> movimentations;
}
