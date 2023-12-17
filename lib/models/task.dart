
import 'package:hive/hive.dart';

part 'task.g.dart';  // red unline is OK for now

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  int highestScore;

  Task({
    required this.highestScore,
  });
  @override
  int get hashCode => Object.hashAll([
    highestScore,
  ]);
}