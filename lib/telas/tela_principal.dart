import 'package:flutter/material.dart';
import 'package:todo_app/tarefa_model/lista_model.dart';
import 'package:todo_app/telas/tela_tarefas.dart';


//Criação de stateful pois a tela será alterada constantemente dependendo de outras interações!

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  //Criação do objeto do tipo ListaModel, para podermos acessar seus métodos
  ListaModel lista = ListaModel();


  @override
  Widget build(BuildContext context) {
    //FutureBuilder para assegurar que os dados serão carregados
    return FutureBuilder(
      future: lista.dados(),
      builder: (context, snapshot){

        var aux = lista.lista;

        return Stack(
          children: <Widget>[
            //Container para fazer o gradient na tela SE REPETE EM TODAS AS TELAS.
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 120, 47, 146)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/a.jpg'),
                          radius: 45.0,
                        ),
                      ),
                      Text(
                        "Olá, Marcelo!!!",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
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
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 35.0),
                        child: Text(lista.countNotMade(aux) == 0 ? "Uffa!!!" :
                          "Não perca tempo!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 35.0),
                        child: Text(lista.countNotMade(aux) == 0 ? "Você não tem mais tarefas para fazer!":
                          "Você ainda tem ${lista.countNotMade(aux)} tarefas para fazer!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[


                          // ESTES MÉTODOS SE REPETEM 3X PARA GERAR AS 3 CATEGORIAS.
                          InkWell(
                            //Caso pressione o card, será redirecionado à página daquela categoria
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen("Casa")));
                              },
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 80.0, right: 35.0),
                                  child: Card(
                                    elevation: 10.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10.0,
                                              offset: Offset(5.0, 5.0),
                                            )
                                          ]),
                                      width: 200,
                                      height: 10,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 20,
                                            left: 30,
                                            //caminho da imagem de icone
                                            child: Image.asset("assets/images/home.png", height: 50.0, width: 50.0,),
                                          ),
                                          Positioned(
                                            bottom: 40,
                                            left: 30,
                                            child: Text(
                                              "Casa",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 70,
                                            left: 30,
                                            child: Text(
                                              //método para verificar quantas atividades da categoria faltam
                                              "${lista.categoryNotMade(aux, "Casa")} tarefas restantes",
                                              style: TextStyle(
                                                  color: Colors.brown[200],
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen("Estudo")));
                              },
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 0.0, right: 35.0),
                                  child: Card(
                                    elevation: 10.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10.0,
                                              offset: Offset(5.0, 5.0),
                                            )
                                          ]),
                                      width: 200,
                                      height: 10,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 20,
                                            left: 30,
                                            child: Image.asset("assets/images/estudo.png", height: 50.0, width: 50.0,),
                                          ),
                                          Positioned(
                                            bottom: 40,
                                            left: 30,
                                            child: Text(
                                              "Estudo",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 70,
                                            left: 30,
                                            child: Text(
                                              "${lista.categoryNotMade(aux, "Estudo")} tarefas restantes",
                                              style: TextStyle(
                                                  color: Colors.brown[200],
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen("Trabalho")));
                              },
                              child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 0.0, right: 35.0),
                                  child: Card(
                                    elevation: 10.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10.0,
                                              offset: Offset(5.0, 5.0),
                                            )
                                          ]),
                                      width: 200,
                                      height: 10,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 20,
                                            left: 30,
                                            child: Image.asset("assets/images/mala.png", height: 50.0, width: 50.0,),
                                          ),
                                          Positioned(
                                            bottom: 40,
                                            left: 30,
                                            child: Text(
                                              "Trabalho",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 70,
                                            left: 30,
                                            child: Text(
                                              "${lista.categoryNotMade(aux, "Trabalho")} tarefas restantes",
                                              style: TextStyle(
                                                  color: Colors.brown[200],
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )))
                        ],
                      ))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

