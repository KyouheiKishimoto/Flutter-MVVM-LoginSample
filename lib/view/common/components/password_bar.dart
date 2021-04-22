

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordBar extends StatelessWidget {
  final ValueChanged onPassword;
  TextEditingController textEditingController = TextEditingController();

  //コンストラクタ
  PasswordBar({this.onPassword,this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(24.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onSubmitted: onPassword,
            maxLines: 1,
            controller: textEditingController,
            decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                hintText: "Password",
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
