import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel{
  @HiveField(0)
  late final int userId;

  @HiveField(1)
  late final String title;

  @HiveField(2)
  late final DateTime createdAt;

  TaskModel({
  required this.userId,
    required this.title,
    required this.createdAt,
});
}

