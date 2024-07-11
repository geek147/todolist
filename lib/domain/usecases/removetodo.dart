import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/core/error/failure.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

@injectable
class RemoveTodo {
  final TodoRepository repository;

  RemoveTodo(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.removeTodo(id);
  }
}
