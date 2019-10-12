import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ListaModel extends Model{

  List lista = [];

  //altera o status de uma atividade
  void changeStatus(int index, List auxiliar){
    auxiliar[index]["feito"] == "true" ? lista[index]["feito"] = "false" : lista[index]["feito"] = "true";
    saveData(auxiliar);
  }

  //carrega os dados
  Future dados () {
    return loadData().then((data){
      lista = json.decode(data);
    });
  }

  //Caminho do arquivo dentro do diretório do arquivo e diretório
  Future<File> get _localFile async {
    final path = await getApplicationDocumentsDirectory();
    return File("${path.path}/data.json");
  }

  //Salvar dados dentro do arquivo
  Future<File> saveData(List lista) async {
    String data = json.encode(lista);
    final file = await _localFile;
    return file.writeAsString(data);
  }

  //Carregar dados de dentro do arquivo
  Future<String> loadData() async {
    try {
      final file = await _localFile;
      return file.readAsStringSync();
    } catch (e) {
      return null;
    }
  }

  //conta a quantidade de categorias
  int categoryCoun(List list, String category){
    int contador = 0;
    for (int i = 0; i < list.length; i++){
      if(list[i]["categoria"] == category){
        contador++;
      }
    }
    return contador;
  }

  //conta a quantidade de atividades no geral que nao foram feitas
  int countNotMade(List list){
    int contador = 0;
    for (int i = 0; i < list.length; i++){
      if(list[i]["feito"] == "false"){
        contador++;
      }
    }
    return contador;
  }

  //atividades de categorias específicas que nao foram feitas
  int categoryNotMade(List list, String category){
    int contador = 0;
    for (int i = 0; i < list.length; i++){
      if(list[i]["feito"] == "false" && list[i]["categoria"] == category){
        contador++;
      }
    }
    return contador;
  }

}