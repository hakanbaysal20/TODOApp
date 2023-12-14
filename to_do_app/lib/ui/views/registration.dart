import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/color_constants.dart';
import 'package:to_do_app/ui/bloc/registration_cubit.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var tfName = TextEditingController();
  var tfDescription = TextEditingController();
  var tfDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: const Text("Add Task",style: TextStyle(fontFamily: 'Jost',color: ColorConstants.white,fontSize: 24,fontWeight: FontWeight.bold),),
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
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.title_outlined,color: ColorConstants.primaryColor,),hintText: "Title",hintStyle: TextStyle(fontFamily: 'Jost')),
                ),
                const SizedBox(height: 50),
                TextField(
                  maxLines: null,
                  controller: tfDescription,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description_outlined,color: ColorConstants.primaryColor,),
                      hintText: "Detail",hintStyle: TextStyle(fontFamily: 'Jost')),
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

              SizedBox(
                width: 300,
                height: 65,
                child: TextButton(onPressed: () {
                 context.read<RegistrationCubit>().saveToDo(tfName.text, tfDescription.text,tfDate.text);
                }, style: TextButton.styleFrom(backgroundColor: ColorConstants.primaryColor,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),

                    child: const Text("ADD",style: TextStyle(fontFamily: 'Jost',fontWeight: FontWeight.bold,fontSize: 20,color: ColorConstants.white),)),
              ),
        ],
      ),

    );
  }
}
