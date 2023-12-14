import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/sqlite/database_assistant.dart';

class ToDoRepository{

  Future<List<ToDoModel>> getToDo() async {
    var db = await DatabaseAccess.databaseAccess();
    List<Map<String,dynamic>> rows = await db.rawQuery("SELECT * FROM todo");
    
    return List.generate(rows.length,(index) {
      var date_time = "";

      var row = rows[index];
      var todo_id = row["todo_id"];
      var todo_name = row["todo_name"];
      var description_name = row["description_name"];
      if(row["date_time"] == null){
        date_time = "";
      }else{
        date_time = row["date_time"];
      }
      return ToDoModel(todo_id: todo_id, todo_name: todo_name, description_name: description_name,date_time: date_time);
    });

  }
  Future<List<ToDoModel>> searchToDo(String searchWord) async {
    var db = await DatabaseAccess.databaseAccess();
    List<Map<String,dynamic>> rows = await db.rawQuery("SELECT * FROM todo WHERE todo_name like '%$searchWord%'");
    return List.generate(rows.length, (index){
      var row = rows[index];
      var todo_id = row["todo_id"];
      var todo_name = row["todo_name"];
      var description_name = row["description_name"];
      var date_time = row["date_time"];

      return ToDoModel(todo_id: todo_id, todo_name: todo_name, description_name: description_name,date_time: date_time);
    });
  }
  Future<void> saveToDo(String todo_name,String todo_description,String date_time) async {
    var db = await DatabaseAccess.databaseAccess();
    var newTodo = Map<String,dynamic>();
    newTodo["todo_name"] = todo_name;
    newTodo["description_name"] = todo_description;
    newTodo["date_time"] = date_time;
    await db.insert("todo", newTodo);
  }
  Future<void> updateToDo(int todo_id,String todo_name,String description_name,String date_time) async {
    var db = await DatabaseAccess.databaseAccess();
    var updateTodo = Map<String,dynamic>();
    updateTodo["todo_name"] = todo_name;
    updateTodo["description_name"] = description_name;
    updateTodo["date_time"] = date_time;
    await db.update("todo", updateTodo,where: "todo_id = ? ",whereArgs: [todo_id]);

  }
  Future<void> deleteToDo(int todo_id) async {
    var db = await DatabaseAccess.databaseAccess();
    await db.delete("todo",where: "todo_id = ?",whereArgs: [todo_id]);
  }

  Future<void> pickDate(BuildContext context,TextEditingController controller) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime
          .now()
          .year + 1),
      builder: (context, child) {
        return child ?? Text("");
      },
    );
    if (newDate == null) {
      return;
    }
    var dob = DateFormat('dd/MM/yyyy').format(newDate);
    controller.text = dob;
  }

}