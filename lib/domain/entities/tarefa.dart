

import 'dart:convert';

class Tarefa{


Tarefa({required this.title,required this.dateTime});
Tarefa.fromJson(Map <String,dynamic> json)
 :title=json['Titulo'],
  dateTime=DateTime.parse(json['dateTime']);



String title;
DateTime dateTime;


Map <String,dynamic>toJson(){
  return{
    'Titulo':title,
    'dateTime':dateTime.toIso8601String()
  };
}

}