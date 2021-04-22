
import 'package:flutter_login_test/data_models/user.dart';
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
];


/**
 * 依存関係のあるProviderを宣言
 */
List<SingleChildWidget> dependentModels = [
  ChangeNotifierProvider<UserRepository>(
    create: (context) => UserRepository(
      loginApiService : Provider.of<LoginApiService>(context, listen: false),
    ),
  ),
];


/**
 * 上二つのProviderを利用したProviderを宣言(ViewModel)
 */
List<SingleChildWidget> viewModels = [

  ChangeNotifierProxyProvider<UserRepository, LoginViewModel>(
    create:(context) => LoginViewModel(
      repository: Provider.of<UserRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) =>
    viewModel..onRepositoryUpdated(repository),
  ),
];