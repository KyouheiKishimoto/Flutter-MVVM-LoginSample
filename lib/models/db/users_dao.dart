import 'package:flutter_login_test/models/db/database_manager.dart';
import 'package:moor/moor.dart';

part 'users_dao.g.dart';

@UseDao(tables: [Users])
class UsersDao extends DatabaseAccessor<DatabaseManager> with _$UsersDaoMixin {
  UsersDao(DatabaseManager db) : super(db);

  //デリートクエリを使用して
  Future clearDB() => delete(usersRecod).go();

  //
  Future insertDB(List<User> user) async {
    await batch(
      (batch) {
        batch.insertAll(usersRecod, user);
      },
    );
  }

  Future<List<User>> get usersFromDB => select(usersRecod).get();

  Future<List<User>> insertAndReadNewsFromDB(
      List<User> user) => transaction(() async {
        await clearDB();
        await insertDB(user);
        return await usersFromDB;
      });
}
