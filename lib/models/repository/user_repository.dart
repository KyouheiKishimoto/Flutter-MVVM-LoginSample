
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_test/data_models/user.dart';
import 'package:flutter_login_test/models/networking/login_api_service.dart';

class UserRepository extends ChangeNotifier{

  // Webからの返り値
  final LoginApiService loginApiService;

  // ログインしているか
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isSuccessful = false;

  bool get isSuccessful => _isSuccessful;

  Response<dynamic> _res;

  Response<dynamic> get res => _res;

  //コンストラクタ
  UserRepository({this.loginApiService});

  /// ログインしているか判定処理
  ///
  /// return [bool]
  ///
  /// true:ログインしている false:ログインしていない
  Future<bool> isSingIn() async {



    return false;
  }

  /// ログイン処理
  ///
  /// return [bool]
  ///
  /// true:ログイン処理成功 false:ログイン処理失敗
  Future<bool> signIn({@required String email, String password}) async {

    print(_res = await loginApiService.getUserInfo(email:email, password: password));

    print("ログインの結果");
    print(_res.body);

    return false;
  }

  /// ログアウト処理
  Future signOut() async {

  }

  /// ユーザーIDを取得
  ///
  /// return [User]　ユーザークラスを返す
  Future<User> getUserById(String userId) async {

  }

}

