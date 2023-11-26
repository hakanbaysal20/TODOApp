import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/ui/bloc/to_do_save_cubit.dart';
import 'package:to_do_app/ui/bloc/todo_cubit.dart';
import 'package:to_do_app/ui/views/to_do_details.dart';
import 'package:to_do_app/ui/views/to_do_save.dart';


class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  void initState() {
    super.initState();
    context.read<ToDoCubit>().loadToDo();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoSave(),))
              .then((value){
            context.read<ToDoCubit>().loadToDo();
              });
       },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("To Do"),centerTitle: true,),
      body: BlocBuilder<ToDoCubit,List<ToDoModel>>(
            builder: (context, todoList) {
              if(todoList.isNotEmpty){
                print("asdasd");
                return ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    var todo = todoList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoDetails(model: todo),))
                            .then((value) {
                              context.read<ToDoCubit>().loadToDo();
                            });
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Text(todo.todo_name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text(todo.description_name,textAlign: TextAlign.center,),

                           Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Yapıldı"),
                                  IconButton(onPressed: () {

                                  }, icon: Icon(Icons.check),color: Colors.green,),
                                  Text("Sil"),
                                  IconButton(onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.blueAccent,
                                          content: Text("Silinsin mi?"),
                                          action: SnackBarAction(label: "Evet",textColor: Colors.white,
                                            onPressed: () {
                                            context.read<ToDoCubit>().deleteToDo(todo.todo_id);
                                          },),

                                        ),
                                    );
                                  }, icon: Icon(Icons.close),color: Colors.red,),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );

                  },
                );
              }else{
                print("asdasd00");
                return Center();
              }
          },)



    );
  }
}
