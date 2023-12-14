
import 'package:to_do_app/sqlite/database_assistant.dart';

import '../entity/to_do_model.dart';

class HistoryRepository{

  Future<List<ToDoModel>> getToDo() async {
    var db = await DatabaseAccess.databaseAccess();
    List<Map<String,dynamic>> rows = await db.rawQuery("SELECT * FROM history");
    return List.generate(rows.length,(index) {
      var date_time = "";

      var row = rows[index];
      var todo_id = row["history_id"];
      var todo_name = row["history_name"];
      var description_name = row["history_description"];
      if(row["history_date_time"] == null){
        date_time = "";
      }else{
        date_time = row["history_date_time"];
      }
      return ToDoModel(todo_id: todo_id, todo_name: todo_name, description_name: description_name,date_time: date_time);
    });

  }



}