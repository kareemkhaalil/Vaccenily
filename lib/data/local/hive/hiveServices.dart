import 'package:dashborad/data/models/userHiveModel.dart';
import 'package:hive/hive.dart';

class HiveService {
  Future<Box<UserHive>> openUserBox() async {
    return await Hive.openBox<UserHive>('userBox');
  }

  Future<void> saveUser(UserHive user) async {
    final userBox = await openUserBox();
    userBox.put('user', user);
  }

  Future<UserHive?> getUser() async {
    final userBox = await openUserBox();
    return userBox.get('user');
  }

  Future<void> deleteUser() async {
    Box<UserHive> userBox = await Hive.openBox<UserHive>('user');
    await userBox.clear();
    await userBox.close();
  }
}
