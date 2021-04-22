import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_test/view/common/components/button_with_icon.dart';
import 'package:flutter_login_test/view/common/components/email_bar.dart';
import 'package:flutter_login_test/view/common/components/password_bar.dart';
import 'package:flutter_login_test/view_models/login_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

/**
 * ログイン画面
 */
class LoginScreen extends StatelessWidget {
  ValueChanged emailText;

  ValueChanged passwordText;

  TextEditingController emailEditValue = TextEditingController();
  TextEditingController passwordEditValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text("ほげ"),
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                        child: Text("ログイン"),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: EmailBar(
                          onEmail: (emailText) =>
                              login(context, emailEditValue, passwordEditValue),
                          textEditingController: emailEditValue,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: PasswordBar(
                          onPassword: (passwordText) =>
                              login(context, emailEditValue, passwordEditValue),
                          textEditingController: passwordEditValue,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ButtonWithIcon(
                        iconData: FontAwesomeIcons.signInAlt,
                        label: "ログインするよ",
                        onPressed: () =>
                            login(context, emailEditValue, passwordEditValue),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Future<void> getUserInfo(BuildContext context, keyword) {
    // viewModelをインスタンス化　※メンバ変数に入れ込み
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);

    print("NewsListPage.getKeywordNews");
  }
}

//ログインの処理
login(BuildContext context, TextEditingController emailEditingController, TextEditingController passwordEditingController) async {
  print("ログインのメソッドに入った");
  print(emailEditingController.text);
  print(passwordEditingController.text);

  final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
  await loginViewModel.signIn(emailEditingController.text,passwordEditingController.text);
  if (!loginViewModel.isSuccessful) {
    Fluttertoast.showToast(msg: "ログイン失敗しました");
    return;
  }else{
    print("通信はしてるみたい");
    Fluttertoast.showToast(msg: "ログイン失敗しました");
    return;
  }
  _openHomeScreen(context);
}

/// emailを取得するだけ
Future<void> getEmail(BuildContext context, keyword) async {
  // viewModelをインスタンス化　※メンバ変数に入れ込み
  final viewModel = Provider.of<LoginViewModel>(context, listen: false);

  print("NewsListPage.getKeywordNews");
}

//ホームに飛ばす
void _openHomeScreen(BuildContext context) {
  //ホームにとりあえず飛ばす
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => HomeScreen()),
  );
}
