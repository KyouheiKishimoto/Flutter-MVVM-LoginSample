

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

  Future<void> signIn(String email, String password) async {

    print("サインイン処理");

    //クルクルにするよ
    _isLoading = true;
    //とりあえずクルクルだけやっとく
    notifyListeners();

    //メンバ変数に値を渡す
    _email = email;
    _password = password;

    //サインイン処理を行って
    _isLoading = await _userRepository.signIn(
      email: _email,
      password: _password,
    );

    _isLoading = false;
    notifyListeners();

  }

  onRepositoryUpdated(UserRepository repository) {
    _isSuccessful = repository.isSuccessful;
    _isLoading = repository.isLoading;
    notifyListeners();
  }


}