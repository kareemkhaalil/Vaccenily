import 'package:hive/hive.dart';

part 'userHiveModel.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String? id;

  UserHive({required this.email, required this.password, required this.id});
}
