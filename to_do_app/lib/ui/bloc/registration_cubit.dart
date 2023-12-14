import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repository/todo_repository.dart';

class RegistrationCubit extends Cubit<void> {

  RegistrationCubit():super(0);
  var tRepo = ToDoRepository();


Future<void> saveToDo(String todo_name, String todo_description,String date_time) async {
  await tRepo.saveToDo(todo_name, todo_description,date_time);
}
Future<void> pickDate(BuildContext context, TextEditingController controller) async{
  await tRepo.pickDate(context, controller);
}


}