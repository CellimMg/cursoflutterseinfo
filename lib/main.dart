import 'package:flutter/material.dart';
import 'package:todo_app/tarefa_model/lista_model.dart';
import 'package:todo_app/telas/home.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ListaModel>(
      model: ListaModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
      ),
    );
  }
}

