import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/data/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> removeTodo(String id);
  Future<void> updateTodo(TodoModel todo);
}

@LazySingleton(as: TodoLocalDataSource)
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<TodoModel> todoBox;

  TodoLocalDataSourceImpl({required this.todoBox});

  @override
  Future<List<TodoModel>> getTodos() async {
    return todoBox.values.toList();
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }

  @override
  Future<void> removeTodo(String id) async {
    await todoBox.delete(id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }
}
