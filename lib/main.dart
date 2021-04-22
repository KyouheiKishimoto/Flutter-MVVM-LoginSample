import 'package:flutter/material.dart';
import 'package:flutter_login_test/di/providers.dart';
import 'package:flutter_login_test/view/home_screen.dart';
import 'package:flutter_login_test/view/login/login_screen.dart';
import 'package:flutter_login_test/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //loginViewModelのローカル変数
    final loginViewModel = LoginViewModel();


    return MaterialApp(
      title: 'Login-Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white30,
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      home: FutureBuilder(
        future: loginViewModel.isSingIn(),
        builder: (context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData && snapshot.data){
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

