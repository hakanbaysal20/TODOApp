import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/bloc/to_do_save_cubit.dart';


class ToDoSave extends StatefulWidget {
  const ToDoSave({Key? key}) : super(key: key);

  @override
  State<ToDoSave> createState() => _ToDoRecordState();
}

class _ToDoRecordState extends State<ToDoSave> {
  var tfName = TextEditingController();
  var tfDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Save"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: tfName,
            decoration: InputDecoration(hintText: "Başlık"),

          ),
          TextField(
            controller: tfDescription,
            decoration: InputDecoration(hintText: "Açıklama yaz"),
          ),
          ElevatedButton(onPressed: () {
            context.read<ToDoSaveCubit>().saveToDo(tfName.text, tfDescription.text);
            Navigator.pop(context);
          }, child: Text("Kaydet")),
        ],
      ),
    );
  }
}
