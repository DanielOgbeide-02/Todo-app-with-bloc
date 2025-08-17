//handles implementation in the isar database: storing, retrieving, updating, deleting..

import 'package:isar/isar.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

import '../../domain/models/todo.dart';

class IsarTodoRepo implements TodoRepo{
  //database
  final Isar db;
  IsarTodoRepo(this.db);
  //get todos
  @override
  Future<List<Todo>> getTodos() async{
    //fetch from db
    final todos = await db.todoIsars.where().findAll();
    //return list of todos and give domain layer
    return todos.map((todoIsar)=> todoIsar.toDomain()).toList();
  }
  //add todo
  @override
  Future<void> addTodo(Todo newTodo) {
    //convert todo into isar todo object
    final todoIsar = TodoIsar.fromDomain(newTodo);
    //store todo in database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
  //update todo
  @override
  Future<void> updateTodo(Todo todo) {
    //convert todo into isar todo object
    final todoIsar = TodoIsar.fromDomain(todo);
    //store todo in database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
  //delete todo
  @override
  Future<void> deleteTodo(Todo todo) async{
    await db.writeTxn(()=>db.todoIsars.delete(todo.id));
  }
}