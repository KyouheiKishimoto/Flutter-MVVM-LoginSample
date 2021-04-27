import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_test/data_models/user.dart';
import 'package:flutter_login_test/models/db/users_dao.dart';
import 'package:flutter_login_test/models/networking/login_api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UserRepository extends ChangeNotifier {
  // Webからの返り値
  final LoginApiService _loginApiService;

  final UsersDao _dao;

  // final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();


  /// ChangeNotifierProviderを参照　つまりここでインスタンス化されたApiServiceとDaoを取得する
  ///
  /// [apiService]　UserApi取得
  ///
  /// [dao] データベース
  UserRepository({dao, apiService})
      : _loginApiService = apiService,
        _dao = dao;

  // ログインしているか
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 成功しているか
  bool _isSuccessful = false;
  bool get isSuccessful => _isSuccessful;

  Response<dynamic> _res;
  Response<dynamic> get res => _res;

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
    print(_res = await _loginApiService.getUserInfo(email: email, password: password));

    print("ログインの結果");
    print(_res.body);
    final snapshot =
    await FirebaseFirestore.instance.collection('users').get();
    print( snapshot);



    // try{
    //
    //   GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    //   GoogleSignInAuthentication signInAuthentication = await signInAccount.authentication;
    //
    //   final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
    //     idToken: signInAuthentication.idToken,
    //     accessToken: signInAuthentication.accessToken,);
    //
    //   final firebaseUser = (await _auth.signInWithCredential(credential)).user;
    //
    //   print("大丈夫だ問題ない");
    //
    //   if (firebaseUser == null) {
    //     print("そんなユーザはいない");
    //     return false;
    //   }
    //
    //   return true;
    // } catch(error){
    //   print("sign in error caught!: ${error.toString()}");
    //   return false;
    // }

    return false;
  }

  /// ログアウト処理
  Future signOut() async {}

  /// ユーザーIDを取得
  ///
  /// return [User]　ユーザークラスを返す
  Future<User> getUserById(String userId) async {}


  @override
  void dispose() {
    _loginApiService.dispose();
    super.dispose();
  }

}
