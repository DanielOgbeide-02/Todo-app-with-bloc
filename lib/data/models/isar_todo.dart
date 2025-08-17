//converts todo model into isar todo model so that we can store in ISAR db
import 'package:isar/isar.dart';

import '../../domain/models/todo.dart';

//generate isar todo object
part 'isar_todo.g.dart';

@collection
class TodoIsar{
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  //convert isar object to pure todo object to use in our app
  Todo toDomain(){
    return Todo(
        id: id,
        text: text,
        isCompleted: isCompleted,
    );
  }

  //convert pure todo object to isar to store in isar db
static TodoIsar fromDomain(Todo todo){
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
}


}