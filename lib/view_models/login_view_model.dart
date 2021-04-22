

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_test/models/repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {

  final UserRepository userRepository;
  LoginViewModel({repository}): userRepository = repository;
  // LoginViewModel({this.userRepository});

  String _email = "";
  String get email => _email;

  String _password = "";
  String get password => _password;

  bool isLoading = false;
  bool isSuccessful = false;

  Future<bool> isSingIn() async {
    return await userRepository.isSingIn();
  }

  Future<void> signIn(String email, String password) async {

    print("サインイン処理");

    //クルクルにするよ
    isLoading = true;
    //とりあえずクルクルだけやっとく
    notifyListeners();

    //メンバ変数に値を渡す
    _email = email;
    _password = password;

    //サインイン処理を行って
    isSuccessful = await userRepository.signIn(
      email: _email,
      password: _password,
    );

    isLoading = false;
    notifyListeners();

  }

  onRepositoryUpdated(UserRepository repository) {
    isSuccessful = repository.isSuccessful;
    isLoading = repository.isLoading;
    notifyListeners();
  }


}