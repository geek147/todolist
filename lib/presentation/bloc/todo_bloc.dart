import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/domain/usecases/addtodo.dart';
import 'package:todolist/domain/usecases/gettodos.dart';
import 'package:todolist/domain/usecases/removetodo.dart';
import 'package:todolist/domain/usecases/updatetodo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final RemoveTodo removeTodo;
  final UpdateTodo updateTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.removeTodo,
    required this.updateTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<RemoveTodoEvent>(_onRemoveTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final todosOrFailure = await getTodos();
    emit(todosOrFailure.fold(
      (failure) => TodoLoadFailure(failure.message),
      (todos) => TodoLoadSuccess(
          todos, _filterTodos(todos, TodoFilter.all), TodoFilter.all),
    ));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    await addTodo(event.todo);
    add(LoadTodos());
  }

  void _onRemoveTodo(RemoveTodoEvent event, Emitter<TodoState> emit) async {
    await removeTodo(event.id);
    add(LoadTodos());
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    await updateTodo(event.todo);
    add(LoadTodos());
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TodoState> emit) {
    if (state is TodoLoadSuccess) {
      final currentState = state as TodoLoadSuccess;
      final filteredTodos = _filterTodos(currentState.todos, event.filter);
      emit(TodoLoadSuccess(currentState.todos, filteredTodos, event.filter));
    }
  }

  List<Todo> _filterTodos(List<Todo> todos, TodoFilter filter) {
    switch (filter) {
      case TodoFilter.completed:
        return todos.where((task) => task.isCompleted).toList();
      case TodoFilter.incomplete:
        return todos.where((task) => !task.isCompleted).toList();
      case TodoFilter.all:
      default:
        return todos;
    }
  }
}
