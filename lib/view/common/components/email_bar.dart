import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailBar extends StatelessWidget {
  final ValueChanged onEmail;
  TextEditingController textEditingController = TextEditingController();

  //コンストラクタ
  EmailBar({this.onEmail,this.textEditingController});

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
            onSubmitted: onEmail,
            maxLines: 1,
            controller: textEditingController,
            decoration: InputDecoration(
                icon: Icon(Icons.mail),
                hintText: "Email",
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
