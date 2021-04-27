
import 'package:auto_data/auto_data.dart';
import 'package:flutter_login_test/data_models/user.dart';
import 'package:flutter_login_test/models/db/database_manager.dart';
import 'package:flutter_login_test/models/db/users_dao.dart';
import 'package:flutter_login_test/models/networking/login_api_service.dart';
import 'package:flutter_login_test/models/repository/user_repository.dart';
import 'package:flutter_login_test/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

/**
 * 依存関係のないProviderを宣言
 */
List<SingleChildWidget> independentModels = [
  Provider<LoginApiService>(
    create: (_) => LoginApiService.create(),
    dispose: (_, loginApiService) => loginApiService.dispose(),
  ),
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
    dispose: (_, db) => db.close(),
  ),
];


/**
 * 依存関係のあるProviderを宣言
 */
List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UsersDao>(
    update: (_, db, dao) => UsersDao(db),
  ),
  ChangeNotifierProvider<UserRepository>(
    create: (context) => UserRepository(
      dao: Provider.of<UsersDao>(context, listen: false),
      apiService : Provider.of<LoginApiService>(context, listen: false),
    ),
  ),
];


/**
 * 上二つのProviderを利用したProviderを宣言(ViewModel)
 */
List<SingleChildWidget> viewModels = [

  ChangeNotifierProxyProvider<UserRepository, LoginViewModel>(
    create:(context) => LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) => viewModel..onRepositoryUpdated(repository),
  ),
];