import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/sqlite/database_assistant.dart';

class ToDoRepository{

  Future<List<ToDoModel>> getToDo() async {
    var db = await DatabaseAccess.databaseAccess();
    List<Map<String,dynamic>> rows = await db.rawQuery("SELECT * FROM todo");
    
    return List.generate(rows.length,(index) {
      var row = rows[index];
      var todo_id = row["todo_id"];
      var todo_name = row["todo_name"];
      var description_name = row["description_name"];
      return ToDoModel(todo_id: todo_id, todo_name: todo_name, description_name: description_name);
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

      return ToDoModel(todo_id: todo_id, todo_name: todo_name, description_name: description_name);
    });
  }
  Future<void> saveToDo(String todo_name,String todo_description) async {
    var db = await DatabaseAccess.databaseAccess();
    var newTodo = Map<String,dynamic>();
    newTodo["todo_name"] = todo_name;
    newTodo["description_name"] = todo_description;
    await db.insert("todo", newTodo);
  }
  Future<void> updateToDo(int todo_id,String todo_name,String description_name) async {
    var db = await DatabaseAccess.databaseAccess();
    var updateTodo = Map<String,dynamic>();
    updateTodo["todo_name"] = todo_name;
    updateTodo["description_name"] = description_name;
    await db.update("todo", updateTodo,where: "todo_id = ? ",whereArgs: [todo_id]);

  }
  Future<void> deleteToDo(int todo_id) async {
    var db = await DatabaseAccess.databaseAccess();
    await db.delete("todo",where: "todo_id = ?",whereArgs: [todo_id]);
  }


}