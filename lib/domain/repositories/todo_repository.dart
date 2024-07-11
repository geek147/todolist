import 'package:todolist/domain/entities/todo.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/core/error/failure.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> removeTodo(String id);
  Future<Either<Failure, void>> updateTodo(Todo todo);
}
