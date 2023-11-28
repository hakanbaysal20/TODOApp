import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/bloc/registration_cubit.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var tfName = TextEditingController();
  var tfDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To Do Save"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: tfName,
            decoration: const InputDecoration(hintText: "Başlık"),

          ),
          TextField(
            controller: tfDescription,
            decoration: const InputDecoration(hintText: "Açıklama yaz"),
          ),
          ElevatedButton(onPressed: () {
            context.read<RegistrationCubit>().saveToDo(tfName.text, tfDescription.text);
          }, child: const Text("Kaydet")),
        ],
      ),
    );
  }
}
