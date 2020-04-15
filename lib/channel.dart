import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/movimentation_model.dart';
import 'package:dart_week_api/routers/category_router.dart';
import 'package:dart_week_api/routers/movimentation_router.dart';
import 'package:dart_week_api/routers/users_router.dart';
import 'dart_week_api.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class DartWeekApiChannel extends ApplicationChannel {
  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = DartWeekApiConfiguration(options.configurationFilePath);
    context = contextWithConnectionInfo(config.database);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();
    UsersRouter.configure(router, context);
    CategoryRouter.configure(router, context);
    MovimentationRouter.configure(router, context);
    return router;
  }

  /*
   * Helper methods
   */

  ManagedContext contextWithConnectionInfo(
      DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
        connectionInfo.username,
        connectionInfo.password,
        connectionInfo.host,
        connectionInfo.port,
        connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }
}

/// An instance of this class reads values from a configuration
/// file specific to this application.
///
/// Configuration files must have key-value for the properties in this class.
/// For more documentation on configuration files, see https://aqueduct.io/docs/configure/ and
/// https://pub.dartlang.org/packages/safe_config.
class DartWeekApiConfiguration extends Configuration {
  DartWeekApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
