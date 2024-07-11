part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;
  final List<Todo> filteredTodos;
  final TodoFilter filter;

  const TodoLoadSuccess(this.todos, this.filteredTodos, this.filter);

  @override
  List<Object> get props => [todos, filteredTodos, filter];
}

enum TodoFilter { all, completed, incomplete }

class TodoLoadFailure extends TodoState {
  final String message;

  const TodoLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
