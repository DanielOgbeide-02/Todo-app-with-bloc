// for our state management

//each cubit is a list of todos
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{
  //reference the todo repo
  final TodoRepo todoRepo;

  //constructor initializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]){
    loadTodos();
  }

  //load
  Future<void> loadTodos() async{
    //fetch list of todos from repo
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as the new state
    emit(todoList);
  }

  //add
  Future<void> addTodos(String text) async{
    //create a new todo with unique id
    final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        text: text
    );

    //save the new todo to repo
    await todoRepo.addTodo(newTodo);
    //re-load
    loadTodos();
  }

  //toggle
  Future<void> toggleCompletion(Todo todo)async{
    //toggle the completion status of the todo
    final updatedTodo = todo.toggleCompletion();

    //update todo in repo with new completion status
    await todoRepo.updateTodo(updatedTodo);

    //re-load
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(Todo todo) async{
    //detele the todo from repo
    await todoRepo.deleteTodo(todo);

    //re-load
    loadTodos();
  }
}