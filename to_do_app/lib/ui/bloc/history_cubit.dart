

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/data/repository/history_repository.dart';

class HistoryCubit extends Cubit<List<ToDoModel>>{
  HistoryCubit():super(<ToDoModel>[]);
  var tRepo = HistoryRepository();

  Future<void> getHistory() async{

    var list = await tRepo.getToDo();
    emit(list);
  }
}