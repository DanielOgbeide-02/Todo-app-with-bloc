import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //show dialog box for user to type
  void _showAddTodoBox(BuildContext context){
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(context: context, builder: (context)=> AlertDialog(
     content: TextField(controller: textController,),
      actions: [
        //cancel button
        TextButton(
            onPressed: ()=> Navigator.of(context).pop(),
            child: const Text('cancel')
        ),
        //add button
        TextButton(
            onPressed: (){
              todoCubit.addTodos(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('add')
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    //todo cubit
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(
            Icons.add
          ),
        ),
          onPressed: ()=> _showAddTodoBox(context)
      ),
      
      body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todos){
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index){
                  //get individual todo object
                  final todo = todos[index];

                  return ListTile(
                    //text
                    title: Text(todo.text),
                    //checkbox
                    leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) => todoCubit.toggleCompletion(todo)
                    ),

                    //delete
                    trailing: IconButton(
                        onPressed: ()=> todoCubit.deleteTodo(todo),
                        icon: const Icon(Icons.cancel)
                    ),


                  );
            });
          }
      ),
    );
  }
}
