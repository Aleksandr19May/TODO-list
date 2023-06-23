import 'package:hive_flutter/adapters.dart';

class Task {
  String taskTitle = '';
  bool completed = false;
  int priority;
  String date;
  String uuid = '';

  Task(
      {required this.taskTitle,
      required this.completed,
       this.priority = 0,
      required this.date,
      required this.uuid});
}

// Адаптер для работы HIVE
class HiveTask extends TypeAdapter<Task> {
  @override
  final typeId = 1;

  @override
  Task read(BinaryReader reader) {
    String taskTitle = reader.readString();
    bool completed = reader.readBool();
    int? priority = reader.readInt();
    String date = reader.readString();
    String uuid = reader.readString();

    return Task(
        taskTitle: taskTitle,
        completed: completed,
        priority: priority,
        date: date,
        uuid: uuid);
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.taskTitle);
    writer.writeBool(obj.completed);
    writer.writeInt(obj.priority);
    writer.writeString(obj.date);
    writer.writeString(obj.uuid);
  }
}
