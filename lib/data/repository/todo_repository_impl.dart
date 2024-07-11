import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/core/error/failure.dart';
import 'package:todolist/data/datasources/todo_local_datasource.dart';
import 'package:todolist/data/models/todo_model.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/repositories/todo_repository.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await localDataSource.getTodos();
      return Right(todos.map((todo) => todo.toEntity()).toList());
    } catch (e) {
      return const Left(CacheFailure('Failed to load todo'));
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      await localDataSource.addTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to add todo'));
    }
  }

  @override
  Future<Either<Failure, void>> removeTodo(String id) async {
    try {
      await localDataSource.removeTodo(id);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to remove todo'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      await localDataSource.updateTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to update todo'));
    }
  }
}
