import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_test/di/providers.dart';
import 'package:flutter_login_test/view/home_screen.dart';
import 'package:flutter_login_test/view/login/login_screen.dart';
import 'package:flutter_login_test/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  //ここで初期化とかが必要なら下のやつ宣言せーよらしいので宣言します
  WidgetsFlutterBinding.ensureInitialized();

  //Firebaseの初期化
  await Firebase.initializeApp();

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

