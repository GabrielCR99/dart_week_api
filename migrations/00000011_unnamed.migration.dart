import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration11 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("movimentation", SchemaColumn("value", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    