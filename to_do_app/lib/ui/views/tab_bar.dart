import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/color_constants.dart';
import 'package:to_do_app/ui/bloc/home_cubit.dart';
import 'package:to_do_app/ui/views/history.dart';
import 'package:to_do_app/ui/views/home.dart';
import 'package:to_do_app/ui/views/registration.dart';
class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().scheduleControl();
    context.read<HomeCubit>().getToDo();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(

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
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.save,color: ColorConstants.white,),
            ),
            Tab(
              icon: Icon(Icons.history,color: ColorConstants.white,),
            ),
          ]),
        ),
        body: TabBarView(children: [
          Home(),
          History(),
          
        ]),
      ),
    );
  }
}
