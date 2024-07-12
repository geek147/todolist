import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/models/todo_model.dart';
import 'package:todolist/domain/usecases/addtodo.dart';
import 'package:todolist/domain/usecases/gettodos.dart';
import 'package:todolist/domain/usecases/removetodo.dart';
import 'package:todolist/domain/usecases/updatetodo.dart';
import 'package:todolist/injection.dart';
import 'package:todolist/presentation/bloc/todo_bloc.dart';
import 'package:todolist/presentation/pages/todopage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(
            getTodos: getIt<GetTodos>(),
            addTodo: getIt<AddTodo>(),
            removeTodo: getIt<RemoveTodo>(),
            updateTodo: getIt<UpdateTodo>(),
          )..add(LoadTodos()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
