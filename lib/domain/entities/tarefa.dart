

class Tarefa{


Tarefa({required this.title,required this.dateTime});

String title;
DateTime dateTime;

/*
Map <String,dynamic>toJson(){
  return{
    'Titulo':title,
    'dateTime':dateTime.toIso8601String()
  };
}
*/
}