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
  Future<void> scheduleControl() async{
    var currentDateTime = DateTime.now();
    var tob = DateFormat('dd/MM/yyyy HH:mm').format(currentDateTime);
    var db = await DatabaseAccess.databaseAccess();
    var newToDo = Map<String,dynamic>();
    var getTodo = await getToDo();
    for(var g in getTodo){
      var dbTime = DateFormat('dd/MM/yyyy HH:mm').parse(g.date_time);
      if(currentDateTime.isAfter(dbTime) || dbTime.isAtSameMomentAs(currentDateTime)){
        newToDo["history_name"] = g.todo_name;
        newToDo["history_description"] = g.description_name;
        newToDo["history_date_time"] = g.date_time;
        await db.insert("history", newToDo);
        await db.delete("todo",where: "todo_id = ? ",whereArgs: [g.todo_id]);
      }
    }
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
    final initialTime = TimeOfDay.now();
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
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return child ?? Text("");
      },
    );
    if (newTime == null) {
      return;
    }
    var scheduleDate = DateTime(newDate.year,newDate.month,newDate.day,newTime.hour,newTime.minute);
    var date = DateFormat('dd/MM/yyyy HH:mm').format(scheduleDate);
    controller.text = date;
  }

}