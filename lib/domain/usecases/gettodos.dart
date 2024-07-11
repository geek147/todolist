import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/core/error/failure.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

@injectable
class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<Either<Failure, List<Todo>>> call() async {
    return await repository.getTodos();
  }
}
