import 'package:get_it/get_it.dart';
import 'package:pinapp_test/app/data/datasource/post_datasource.dart';
import 'package:pinapp_test/app/data/repositories/post_repository_impl.dart';
import 'package:pinapp_test/app/domain/repositories/post_repository.dart';

final sl = GetIt.instance;

/// Service Locator
class ServiceLocator {
  static initDependencies() {
    /// DataSources
    sl.registerSingleton<PostDatasource>(PostDatasourceImpl());

    /// Repositories
    sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl()));
  }
}
