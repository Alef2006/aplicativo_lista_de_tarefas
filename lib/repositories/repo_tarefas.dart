

import 'package:aplication_task_list/domain/entities/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RepositorioTarefas{



late SharedPreferences sharedPreferences;


Future <void>getListaDeTarefa() async{
  
  sharedPreferences= await SharedPreferences.getInstance();
}

void salvarLista(List<Tarefa> todo){
 final String jsonString= json.encode (todo);
 sharedPreferences.setString('Lista_tarefas',jsonString);
}



}

