import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/ui/bloc/details_cubit.dart';


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
      appBar: AppBar(title: const Text("To Do Details"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
            children: [
              TextField(
                maxLines: null,
                controller: tfName,
                decoration: InputDecoration(border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),hintText: widget.model.todo_name),
              ),
              const SizedBox(height: 50),
              TextField(
                maxLines: null,
                controller: tfDescription,
                decoration: InputDecoration(border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),hintText: widget.model.description_name),
              ),
              ElevatedButton(onPressed: () {
                context.read<DetailsCubit>().updateToDo(widget.model.todo_id,tfName.text,tfDescription.text);
              }, child: const Text("Güncelle")),
            ],
          ),

      ),
    );
  }
}
