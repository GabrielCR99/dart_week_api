import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration8 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("category", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("categoryType", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("movimentation", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("movimentationDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("movimentation", SchemaColumn.relationship("user", ManagedPropertyType.integer, relatedTableName: "uuser", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("movimentation", SchemaColumn.relationship("category", ManagedPropertyType.integer, relatedTableName: "category", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    