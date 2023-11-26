import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repository/todo_repository.dart';

class ToDoDetailsCubit extends Cubit<void> {
  ToDoDetailsCubit():super(0);

  var tRepo = ToDoRepository();

  Future<void> updateToDo(int todo_id,String todo_name,String todo_description) async {
    await tRepo.updateToDo(todo_id, todo_name, todo_description);
  }
}