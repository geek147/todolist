// lib/injection/hive_module.dart
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/data/models/todo_model.dart';

@module
abstract class HiveModule {
  // ignore: invalid_annotation_target
  @preResolve
  Future<Box<TodoModel>> get todoBox => Hive.openBox<TodoModel>('todoBox');
}
