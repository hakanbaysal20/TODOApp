import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/bloc/details_cubit.dart';
import 'package:to_do_app/ui/bloc/history_cubit.dart';
import 'package:to_do_app/ui/bloc/registration_cubit.dart';
import 'package:to_do_app/ui/bloc/home_cubit.dart';
import 'package:to_do_app/ui/views/home.dart';
import 'package:to_do_app/ui/views/tab_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(),),
        BlocProvider(create: (context) => DetailsCubit(),),
        BlocProvider(create: (context) => RegistrationCubit(),),
        BlocProvider(create: (context) => HistoryCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TabBarScreen(),
      ),
    );
  }
}