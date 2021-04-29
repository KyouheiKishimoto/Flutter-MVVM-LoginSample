import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_test/models/db/users_dao.dart';
import 'package:flutter_login_test/models/networking/login_api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository extends ChangeNotifier {
  // Webからの返り値
  final LoginApiService _loginApiService;

  final UsersDao _dao;

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

  //グーグル認証
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //FacebookLogin
  // final FirebaseAuth _authFacebook = FirebaseAuth.instance;
  // final FacebookLogin _facebooklogin = new FacebookLogin();

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
    //Webにログイン内容を投げてその返り値です
    _res = await _loginApiService.getUserInfo(email: email, password: password);

    print("ログインの結果");
    print(_res.body);

    //Firestore側のデータが存在しているかの判定
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where(
          "email",
          isEqualTo: email,
        )
        .where("password", isEqualTo: password)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    //Firestoreに存在していない・Web側に存在している場合データベースに保存する
    if (_res.body['uid'] != "999") {
      print("長さは");
      print(documents.length);
      if (documents.length == 0) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_res.body['uid'])
            .set({
          'email': _res.body['email'],
          'password': _res.body['password'],
          'token': _res.body['token'],
        });
      }
      return true;
    }

    return false;
  }

  Future setUser() async {
    await FirebaseFirestore.instance.collection('users').doc("0").set({
      'uid': '1',
      'name': '岸本 匡平',
      'sex': '男',
      'discription': '良い男です',
      'email': 'kisimoto1114@gmail.com',
      'password': 'Kk199614',
    });
  }

  Future<bool> googleSignIn() async {
    print("認証処理のTry");

    try {
      GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      final firebaseUser = (await _auth.signInWithCredential(credential)).user;
      if (firebaseUser == null) {
        return false;
      }
      print("これが認証したデータだ");
      print(firebaseUser.displayName);
      print(firebaseUser.email);
      print(firebaseUser.uid);
      print(firebaseUser.);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set({
        'email': firebaseUser.email,
        'name': firebaseUser.displayName,
        'emailVerified': firebaseUser.emailVerified,
      });
      // final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      // if(!isUserExistedInDb){
      //   await dbManager.insertUser(_convertToUser(firebaseUser));
      // }
      // currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } catch (error) {
      print("sign in error caught!: ${error.toString()}");
      return false;
    }
  }

  // Future<bool> facebookSignIn() async {
  //   print("Facebookの処理");
  //
  //   // Facebookの認証画面が開く
  //   final facebookLoginResult = await _facebooklogin.logIn((['email']));
  //
  //   final AuthCredential credential = FacebookAuthProvider.credential(
  //     facebookLoginResult.accessToken.token,
  //   );
  //
  //   // Firebaseのユーザー情報を取得
  //   print((await _authFacebook.signInWithCredential(credential)).user.email);
  //   print((await _authFacebook.signInWithCredential(credential)).user.displayName);
  // }

  Future<bool> chkUser(String email, String password) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where(
          "email",
          isEqualTo: email,
        )
        .where("password", isEqualTo: password)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    print("docを表示しました");

    if (documents != null && documents.length != 0) {
      return true;
    } else {
      return false;
    }
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
