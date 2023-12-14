import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/color_constants.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/ui/bloc/details_cubit.dart';

import '../bloc/registration_cubit.dart';


class Details extends StatefulWidget {
  ToDoModel model;


  Details({required this.model});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var tfName = TextEditingController();
  var tfDescription = TextEditingController();
  var tfDate = TextEditingController();
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
      appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          title: const Text("Edit Task",style: TextStyle(fontFamily: 'Jost',color: ColorConstants.white,fontSize: 24,fontWeight: FontWeight.bold),),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
            
          }, icon: const Icon(Icons.arrow_back,size: 30,color: Colors.white,)),
        ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24,right: 24),
                child: Column(
                  children: [
                    TextField(
                      maxLines: null,
                      controller: tfName,
                      decoration: const InputDecoration(hintText: "Title",hintStyle: TextStyle(fontFamily: 'Jost')),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      maxLines: null,
                      controller: tfDescription,
                      decoration: const InputDecoration(hintText: "Detail",hintStyle: TextStyle(fontFamily: 'Jost')),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: tfDate,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.watch_later_outlined,color: ColorConstants.primaryColor,),
                          hintText: tfDate.text),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'DATE';
                        }
                        return null;
                      },
                      onTap: () => context.read<RegistrationCubit>().pickDate(context,tfDate),

                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 170,
                    height: 65,
                    child: TextButton(onPressed: () {
                      context.read<DetailsCubit>().updateToDo(widget.model.todo_id,tfName.text,tfDescription.text,tfDate.text);
                    }, style: TextButton.styleFrom(backgroundColor: ColorConstants.primaryColor,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),

                        child: const Text("Update",style: TextStyle(fontFamily: 'Jost',color: ColorConstants.white),)),
                  ),
                  SizedBox(
                    width: 170,
                    height: 65,
                    child: TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, style: TextButton.styleFrom(backgroundColor: ColorConstants.primaryColor,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),

                        child: const Text("Cancel",style: TextStyle(fontFamily: 'Jost',color: ColorConstants.white),)),
                  ),
                ],
              ),
            ],
          ),


    );
  }
}
