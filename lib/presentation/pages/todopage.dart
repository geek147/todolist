// lib/presentation/pages/task_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/domain/entities/todo.dart';
import 'package:todolist/presentation/bloc/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<TodoFilter>(
            onSelected: (filter) {
              context.read<TodoBloc>().add(ChangeFilterEvent(filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TodoFilter.all,
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: TodoFilter.completed,
                child: Text('Completed'),
              ),
              const PopupMenuItem(
                value: TodoFilter.incomplete,
                child: Text('Incomplete'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoadSuccess) {
            return ListView.builder(
              itemCount: state.filteredTodos.length,
              itemBuilder: (context, index) {
                final task = state.filteredTodos[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TodoBloc>().add(UpdateTodoEvent(
                            Todo(
                                id: task.id,
                                title: task.title,
                                isCompleted: value!),
                          ));
                    },
                  ),
                  onLongPress: () {
                    context.read<TodoBloc>().add(RemoveTodoEvent(task.id));
                  },
                );
              },
            );
          } else if (state is TodoLoadFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No tasks'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: context.read<TodoBloc>(),
                child: AddTaskDialog(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Task Title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final task = Todo(
              id: DateTime.now().toString(),
              title: _controller.text,
            );
            context.read<TodoBloc>().add(AddTodoEvent(task));
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
