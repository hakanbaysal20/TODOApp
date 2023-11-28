
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/data/repository/todo_repository.dart';

class HomeCubit extends Cubit<List<ToDoModel>> {

  HomeCubit():super(<ToDoModel>[]);

  var tRepo = ToDoRepository();

  Future<void> getToDo() async{
    var list = await tRepo.getToDo();
    emit(list);
  }
  Future<void> searchToDo(String searchWord) async {
    var list = await tRepo.searchToDo(searchWord);
    emit(list);
  }
  Future<void> deleteToDo(int todo_id) async {
    await tRepo.deleteToDo(todo_id);
    getToDo();
  }



}