

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_test/models/repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {

  final UserRepository _userRepository;

  LoginViewModel({userRepository}): _userRepository = userRepository;

  String _email = "";
  String get email => _email;

  String _password = "";
  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccessful = false;
  bool get isSuccessful => _isSuccessful;

  @override
  void dispose() {
    _userRepository.dispose();
    super.dispose();
  }

  Future<bool> isSingIn() async {
    return await _userRepository.isSingIn();
  }

  ///　ユーザーを追加する処理
  Future<void> setUser() async {
    await _userRepository.setUser();
  }

  Future<bool> googleSignIn() async {
    await _userRepository.googleSignIn();
  }

  // Future<bool> facebookSignIn() async {
  //   await _userRepository.facebookSignIn();
  // }

  Future<void> signIn(String email, String password) async {

    print("サインイン処理");

    //クルクルにするよ
    _isLoading = true;
    //とりあえずクルクルだけやっとく
    notifyListeners();

    //メンバ変数に値を渡す
    _email = email;
    _password = password;

    if(_email != null && _email != "" && _password != null && _password != "" ) {
      //サインイン処理を行って
      _isSuccessful = await _userRepository.signIn(
        email: _email,
        password: _password,
      );
    }else{
      print("なんにも入力されていないでログインするが押された場合の処理");
    }

    _isLoading = false;
    notifyListeners();

  }

  onRepositoryUpdated(UserRepository repository) {
    _isSuccessful = repository.isSuccessful;
    _isLoading = repository.isLoading;
    notifyListeners();
  }


}