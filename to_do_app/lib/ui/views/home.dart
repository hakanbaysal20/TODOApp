import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: isSearch ? TextField(decoration: const InputDecoration(hintText: "Ara"),onChanged: (value) {
          context.read<HomeCubit>().searchToDo(value);
        },) : const Text("To Do"),
        centerTitle: true,
        actions: [
          isSearch ?
              IconButton(onPressed: () {
                setState(() {
                  isSearch = false;
                });
              }, icon: const Icon(Icons.clear))

              :IconButton(onPressed: () {
                setState(() {
                  isSearch = true;
                });
              }, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<HomeCubit,List<ToDoModel>>(
            builder: (context, todoList) {
              if(todoList.isNotEmpty){
                print("asdasd");
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                      child: Card(
                        child: Column(
                          children: [
                            Text(todo.todo_name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                            Text(todo.description_name,textAlign: TextAlign.center,),
                                  Spacer(),

                                  TextButton(onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.blueAccent,
                                          content: const Text("Silinsin mi?"),
                                          action: SnackBarAction(label: "Evet",textColor: Colors.white,
                                            onPressed: () {
                                            context.read<HomeCubit>().deleteToDo(todo.todo_id);
                                          },),

                                        ),
                                    );
                                  }, child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                       Icon(Icons.close,color: Colors.red,),
                                     Text("Sil",style: TextStyle(color: Colors.black87),),
                                    ],
                                  ),),
                          ],
                        ),
                      ),
                    );

                  },
                );
              }else{
                print("asdasd00");
                return const Center();
              }
          },)



    );
  }
}
