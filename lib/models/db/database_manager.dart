import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:flutter_login_test/models/db/users_dao.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database_manager.g.dart';

class Users extends Table {
  IntColumn get uid => integer().autoIncrement()(); // 自動採番id
  TextColumn get email => text()(); // 制約をつける
  TextColumn get password => text().named("pass")(); // カラムに別名をつける
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'users.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Users], daos: [UsersDao])
class DatabaseManager extends _$DatabaseManager{
  //Providerさんがこれを呼ぶ
  DatabaseManager() : super(_openConnection());

  //データベースのバージョン
  @override
  int get schemaVersion => 1;

}
