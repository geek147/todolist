import 'package:hive/hive.dart';
import 'package:todolist/domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool isCompleted;

  const TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  }) : super(id: id, title: title, isCompleted: isCompleted);

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
        id: todo.id, title: todo.title, isCompleted: todo.isCompleted);
  }

  Todo toEntity() {
    return Todo(id: id, title: title, isCompleted: isCompleted);
  }
}
