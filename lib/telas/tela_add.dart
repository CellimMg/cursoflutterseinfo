import 'package:flutter/material.dart';

import 'package:todo_app/tarefa_model/lista_model.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  ListaModel lista = ListaModel();

  TextEditingController txtTitle = TextEditingController();
  TextEditingController description = TextEditingController();

  var _category = ["Trabalho", "Casa", "Estudo"];
  var _currentItem = "Trabalho";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 120, 47, 146),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 120, 47, 146)
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(

                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 90,
                        child: Text(
                          "Título",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  // bottomLeft
                                    offset: Offset(-1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                  // bottomRight
                                    offset: Offset(1.5, -1.5),
                                    color: Colors.black),
                                Shadow(
                                  // topRight
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.black),
                                Shadow(
                                  // topLeft
                                    offset: Offset(-1.5, 1.5),
                                    color: Colors.black),
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          width: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: txtTitle,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Título da tarefa",
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: 90,
                          child: Container(
                            width: 100,
                            child: Text(
                              "Categoria",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      // bottomLeft
                                        offset: Offset(-1.5, -1.5),
                                        color: Colors.black),
                                    Shadow(
                                      // bottomRight
                                        offset: Offset(1.5, -1.5),
                                        color: Colors.black),
                                    Shadow(
                                      // topRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.black),
                                    Shadow(
                                      // topLeft
                                        offset: Offset(-1.5, 1.5),
                                        color: Colors.black),
                                  ]),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: 110,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down_circle),
                          items: _category.map((valor) {
                            return DropdownMenuItem(
                              value: valor,
                              child: Text(
                                valor,
                                style: TextStyle(),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValor) {
                            setState(() {
                              this._currentItem = newValor;
                            });
                          },
                          value: _currentItem,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Descrição",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: Colors.black),
                          Shadow(
                            // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: Colors.black),
                          Shadow(
                            // topRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.black),
                          Shadow(
                            // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: Colors.black),
                        ]),
                  ),
                  Container(
                    child: Padding(
                          padding: EdgeInsets.all(15),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)
                              ),
                              child: TextField(
                                controller: description,
                                textInputAction: TextInputAction.go,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Descreva a sua tarefa aqui",
                              ),
                            ),
                          )
                      )),
                      SizedBox(height: 5),
                      FutureBuilder(
                        future: lista.dados(),
                        builder: (context,snapshot){
                          var list = lista.lista;
                          return MaterialButton(onPressed: (){

                            //se os campos estiverem preenchidos, vai criar um map newTodo para receber os valores e vai adicionar isso na list para entao ser passo para o json através do metodo saveData.
                            if(txtTitle.text != "" && txtTitle.text != null){
                              Map<String, dynamic> newTodo = Map();

                              newTodo["title"] = txtTitle.text;
                              newTodo["description"] = description.text;
                              newTodo["feito"] = "false";
                              newTodo["categoria"] = _currentItem;

                              list.add(newTodo);

                              lista.saveData(list);

                              _showDialog("Sucesso!", "Sua tarefa foi salva!");
                            //caso nao esteja preenchido vai exibir a dialog
                            }else{
                              _showDialog("Falha!", "Sua tarefa não foi salva, adicione um título!");
                            }
                                                     },
                            child: Text("Add"),
                            color: Colors.green[500],
                            highlightColor: Colors.green[800],);
                        },
                      )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  //caixa de diálogo
  void _showDialog(String success, String msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(success),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Legal!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
