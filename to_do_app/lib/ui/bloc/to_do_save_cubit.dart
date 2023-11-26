import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repository/todo_repository.dart';

class ToDoSaveCubit extends Cubit<void> {

  ToDoSaveCubit():super(0);
  var tRepo = ToDoRepository();


Future<void> saveToDo(String todo_name, String todo_description) async {
  await tRepo.saveToDo(todo_name, todo_description);
}


}