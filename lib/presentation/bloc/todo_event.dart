part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final String id;

  const RemoveTodoEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  const UpdateTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class ChangeFilterEvent extends TodoEvent {
  final TodoFilter filter;

  const ChangeFilterEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
