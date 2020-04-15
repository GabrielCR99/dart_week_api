import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/user_model.dart';

import '../dart_week_api.dart';

class MovimentationModel extends ManagedObject<_MovimentationModel>
    implements _MovimentationModel {}

@Table(name: 'movimentation')
class _MovimentationModel {
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  String description;

  @Column()
  DateTime movimentationDate;

  @Column()
  double value;

  @Relate(#movimentations)
  UserModel user;

  @Relate(#movimentations)
  CategoryModel category;
}
