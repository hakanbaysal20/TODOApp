import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/ui/bloc/details_cubit.dart';
import 'package:to_do_app/ui/bloc/registration_cubit.dart';


class Details extends StatefulWidget {
  ToDoModel model;


  Details({required this.model});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var tfName = TextEditingController();
  var tfDescription = TextEditingController();
  @override
  void initState() {
    super.initState();
    var todo = widget.model;
    tfName.text = todo.todo_name;
    tfDescription.text = todo.description_name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Details"),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tfName,
              decoration: InputDecoration(hintText: widget.model.todo_name),
            ),
            TextField(
              controller: tfDescription,
              decoration: InputDecoration(hintText: widget.model.description_name),
            ),
            ElevatedButton(onPressed: () {
              context.read<DetailsCubit>().updateToDo(widget.model.todo_id,tfName.text,tfDescription.text);
            }, child: Text("Güncelle")),
          ],
        ),
      ),
    );
  }
}
