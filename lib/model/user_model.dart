import 'package:dart_week_api/model/movimentation_model.dart';

import '../dart_week_api.dart';

class UserModel extends ManagedObject<_UserModel> implements _UserModel {}

@Table(name: 'uuser')
class _UserModel {
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column(unique: true)
  String login;

  @Column()
  String password;

  ManagedSet<MovimentationModel> movimentations;
}
