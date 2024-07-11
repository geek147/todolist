import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/core/error/failure.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

@injectable
class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<Either<Failure, void>> call(Todo todo) async {
    return await repository.updateTodo(todo);
  }
}
