import 'package:flutter/material.dart';
import 'package:todo_app/telas/tela_add.dart';
import 'package:todo_app/telas/tela_principal.dart';

//a
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
            }),
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 120, 47, 146),
        ),
        body: FirstScreen()
    );
  }
}
