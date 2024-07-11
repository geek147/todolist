// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:todolist/data/datasources/todo_local_datasource.dart' as _i5;
import 'package:todolist/data/models/todo_model.dart' as _i4;
import 'package:todolist/data/repository/todo_repository_impl.dart' as _i7;
import 'package:todolist/domain/repositories/todo_repository.dart' as _i6;
import 'package:todolist/domain/usecases/addtodo.dart' as _i11;
import 'package:todolist/domain/usecases/gettodos.dart' as _i8;
import 'package:todolist/domain/usecases/removetodo.dart' as _i9;
import 'package:todolist/domain/usecases/updatetodo.dart' as _i10;
import 'package:todolist/hive_module.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> build({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveModule = _$HiveModule();
    await gh.factoryAsync<_i3.Box<_i4.TodoModel>>(
      () => hiveModule.todoBox,
      preResolve: true,
    );
    gh.lazySingleton<_i5.TodoLocalDataSource>(() =>
        _i5.TodoLocalDataSourceImpl(todoBox: gh<_i3.Box<_i4.TodoModel>>()));
    gh.lazySingleton<_i6.TodoRepository>(() =>
        _i7.TodoRepositoryImpl(localDataSource: gh<_i5.TodoLocalDataSource>()));
    gh.factory<_i8.GetTodos>(() => _i8.GetTodos(gh<_i6.TodoRepository>()));
    gh.factory<_i9.RemoveTodo>(() => _i9.RemoveTodo(gh<_i6.TodoRepository>()));
    gh.factory<_i10.UpdateTodo>(
        () => _i10.UpdateTodo(gh<_i6.TodoRepository>()));
    gh.factory<_i11.AddTodo>(() => _i11.AddTodo(gh<_i6.TodoRepository>()));
    return this;
  }
}

class _$HiveModule extends _i12.HiveModule {}
