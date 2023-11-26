import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/bloc/to_do_details_cubit.dart';
import 'package:to_do_app/ui/bloc/to_do_save_cubit.dart';
import 'package:to_do_app/ui/bloc/todo_cubit.dart';
import 'package:to_do_app/ui/views/to_do.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ToDoCubit(),),
        BlocProvider(create: (context) => ToDoDetailsCubit(),),
        BlocProvider(create: (context) => ToDoSaveCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ToDo(),
      ),
    );
  }
}