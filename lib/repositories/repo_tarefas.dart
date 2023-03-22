

import 'package:aplication_task_list/domain/entities/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


const listKey='Lista_tarefas';
class RepositorioTarefas{
  

RepositorioTarefas(){
  SharedPreferences.getInstance().then((value) => sharedPreferences=value);
}

late SharedPreferences sharedPreferences;


Future<List<Tarefa>> getTarefas() async{
   
   sharedPreferences= await SharedPreferences.getInstance();
   final String jsonString= sharedPreferences.getString(listKey)?? '[]';
   final List jsonDecoder= json.decode(jsonString) as List;
   return jsonDecoder.map((e) => Tarefa.fromJson(e)).toList();
}



void salvarLista(List<Tarefa> todo){
 final String jsonString= json.encode (todo);
 sharedPreferences.setString(listKey,jsonString);
}



}

