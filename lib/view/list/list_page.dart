import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_test/view/list/sub/list_sub_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../style.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro),
          onPressed: () => print("カメラボタン押された"),
        ),
        title: Text(
          "テスト",
          style: TextStyle(fontFamily: TitleFont),
        ),
      ),
      body: ListSubPage(),
    );
  }
}
