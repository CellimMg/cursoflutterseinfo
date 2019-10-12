import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_app/tarefa_model/lista_model.dart';

class DetailScreen extends StatefulWidget {
  final String category;
  DetailScreen(this.category);

  @override
  _DetailScreenState createState() => _DetailScreenState(category);
}

class _DetailScreenState extends State<DetailScreen> {

  //a categoria é definida ao clicar na tela anterior
  final String category;


  final ListaModel list = ListaModel();



  //variáveis para trabalhar no snackBar
  var _lastRemoved;
  var _lastPos;

  _DetailScreenState(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 120, 47, 146),
        ),
        body: FutureBuilder(
            future: list.dados(),
            builder: (context, snapshot){

              //auxiliar que recebe a lista para manipulaçao e depois salvar no json
              var auxiliar = list.lista;
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 120, 47, 146)
                        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          this.category,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white,
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
                        height: 30.0,
                      ),
                      //barra de progresso
                      LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        width: 240.0,
                        lineHeight: 20.0,
                        //calculode porcentagem
                        percent: (list.categoryCoun(auxiliar, category) - list.categoryNotMade(auxiliar, category)) / list.categoryCoun(auxiliar, category),
                        backgroundColor: Colors.white,
                        progressColor: Colors.green,
                        center: Text( list.categoryCoun(auxiliar, category) > 0 ? "${(((list.categoryCoun(auxiliar, category) - list.categoryNotMade(auxiliar, category)) / list.categoryCoun(auxiliar, category))*100).toStringAsFixed(0)}% completo" : "Você não tem tarefas"),
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                            itemCount: auxiliar.length,
                            itemBuilder: (context, index) {
                              if (auxiliar[index]["categoria"] == category) {
                                return Dismissible(
                                    direction: DismissDirection.startToEnd,
                                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                                    onDismissed: (direction) {
                                      _lastRemoved = Map.from(auxiliar[index]);
                                      _lastPos = index;

                                      setState(() {
                                        auxiliar.removeAt(index);
                                      });

                                      list.saveData(auxiliar);
                                      // Then show a snackbar.

                                      final snack = SnackBar(content: Text("Tarefa $index removida."),
                                        action: SnackBarAction(label: "DESFAZER",
                                            onPressed: (){
                                              setState(() {
                                                auxiliar.insert(_lastPos, _lastRemoved);
                                              });

                                              list.saveData(auxiliar);
                                            }
                                        ),
                                        duration: Duration(seconds: 3),
                                      );
                                      Scaffold.of(context).showSnackBar(snack);
                                    },
                                    background: Container(color: Colors.red,
                                        alignment: Alignment(-0.9, 0),
                                        child: Icon(
                                            Icons.delete,
                                            color: Colors.white)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Card(
                                          child:
                                          ExpansionTile(
                                            title: Text(auxiliar[index]["title"]),
                                            leading: InkWell(
                                              //alterar o status do ícone
                                              onTap: () {
                                                list.changeStatus(index, auxiliar);
                                                setState(() {
                                                });
                                              },
                                              //lógica dos icones
                                              child: Icon(
                                                auxiliar[index]["feito"] == "true" ? Icons.check : Icons.cancel,
                                                color: auxiliar[index]["feito"] == "true" ? Colors.green : Colors.red,
                                              ),
                                            ),
                                            children: <Widget>[
                                              ConstrainedBox(
                                                  constraints: const BoxConstraints(minWidth: double.infinity),
                                                  child: Padding(
                                                      padding:
                                                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                                      child: Text(
                                                        list.lista[index]["description"],
                                                        textAlign: TextAlign.start,
                                                        maxLines: 5,
                                                      ))),
                                            ],
                                          )

                                      ),
                                    )
                                );
                              } else {
                                return Center(
                                );
                              }
                            }),
                      )
                    ],
                  )
                ],
              );
            }));
  }
}



