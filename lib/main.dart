import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import 'package:todo_bloc/data/respository/isar_todo_repo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();
  //open isar db
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  //initialize repo with isar data
  final isarTodoRepo = IsarTodoRepo(isar);
  //run app
  runApp(MyApp(todoRepo: isarTodoRepo,));
}

class MyApp extends StatelessWidget {

  //db injection throughout app
  final TodoRepo todoRepo;

  const MyApp({super.key,required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}

