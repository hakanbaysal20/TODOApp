import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/color_constants.dart';
import 'package:to_do_app/data/entity/to_do_model.dart';
import 'package:to_do_app/ui/bloc/home_cubit.dart';
import 'package:to_do_app/ui/views/details.dart';
import 'package:to_do_app/ui/views/registration.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getToDo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColorLight,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Registration(),))
              .then((value){
            context.read<HomeCubit>().getToDo();
              });
       },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: isSearch ? TextField(decoration: const InputDecoration(hintText: "Ara",hintStyle: TextStyle(color: ColorConstants.white)),onChanged: (value) {
          context.read<HomeCubit>().searchToDo(value);
        },) : const Text("TODO APP",style: TextStyle(color: ColorConstants.white,fontSize: 24,fontFamily: 'Jost',fontWeight: FontWeight.bold),),

        actions: [
          isSearch ?
              IconButton(onPressed: () {
                setState(() {
                  isSearch = false;
                });
              }, icon: const Icon(Icons.clear,color: ColorConstants.white,))
              :IconButton(onPressed: () {
                setState(() {
                  isSearch = true;
                });
              }, icon: const Icon(Icons.search,color: ColorConstants.white,)),
        ],
      ),
      body: BlocBuilder<HomeCubit,List<ToDoModel>>(
            builder: (context, todoList) {
              if(todoList.isNotEmpty){
                return ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    var todo = todoList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(model: todo),))
                            .then((value) {
                              context.read<HomeCubit>().getToDo();
                            });
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16,left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(todo.todo_name,style: const TextStyle(color: ColorConstants.primaryColor,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Jost')),

                                        Text(todo.description_name,style: TextStyle(fontFamily: 'Jost',fontSize: 13,)),
                                      ],
                                  ),
                                   ),
                                Column(
                                  children: [
                                    Text(todo.date_time),
                                    IconButton(onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: ColorConstants.white,
                                          content: const Text("Silinsin mi?",style: TextStyle(color: ColorConstants.primaryColorLight),),
                                          action: SnackBarAction(label: "Evet",textColor: ColorConstants.primaryColorLight,
                                            onPressed: () {
                                              context.read<HomeCubit>().deleteToDo(todo.todo_id);
                                            },),

                                        ),
                                      );
                                    }, icon: Icon(Icons.delete_outline_outlined,size: 25,color: ColorConstants.primaryColorLight,),
                                    ),
                                  ],
                                )],
                            ),
                          ),
                        ),
                      ),
                    );

                  },
                );
              }else{
                return const Center();
              }
          },)



    );
  }
}
