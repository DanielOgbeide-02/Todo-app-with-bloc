import '../models/todo.dart';

abstract class TodoRepo{
  //get todo list
  Future<List<Todo>> getTodos();
  //add todo
  Future<void> addTodo(Todo newTodo);
  //update todo
  Future<void> updateTodo(Todo todo);
  //delete todo
  Future<void> deleteTodo(Todo todo);

}