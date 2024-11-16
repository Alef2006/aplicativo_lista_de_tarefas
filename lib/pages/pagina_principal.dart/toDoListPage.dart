import 'package:aplication_task_list/domain/entities/tarefa.dart';
import 'package:aplication_task_list/pages/pagina_principal.dart/listas/listaTasks.dart';
import 'package:aplication_task_list/repositories/repo_tarefas.dart';
import 'package:flutter/material.dart';



class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController taskController = TextEditingController();
  final RepositorioTarefas repo=RepositorioTarefas();
  List<Tarefa> tarefas = [];
  Tarefa? deletedTask;
  int? deletedTaskIndice;
  List<Tarefa>? tarefasDeleted;
  String?textError;

  @override
  void initState() {
    super.initState();
    repo.getTarefas().then((value) => {
       setState(() {
       tarefas=value;     
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Lista de tarefas',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 33, 205, 10),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              
                              style: TextStyle(
                                color: Color.fromARGB(255, 33, 205, 10),
                              ),
                              controller: taskController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                    errorText: textError,
                                labelText: 'Adicione uma tarefa',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 33, 205, 10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 33, 205, 10),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 33, 205, 10),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 33, 205, 10),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                hintText: 'Ex:Estudar flutter',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 33, 205, 10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              String text = taskController.text;
                              if(text.isEmpty){
                                setState(() {
                                  textError='Digite algo no campo de texto';
                                });
                                  return;
                              }
                              setState(() {
                                Tarefa newTarefa = Tarefa(
                                    title: text, dateTime: DateTime.now());
                                tarefas.add(newTarefa);
                              });

                              taskController.clear();
                              repo.salvarLista(tarefas);
                              textError=null;
                            },
                            style: ButtonStyle(backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                    (states) {
                              return Color.fromARGB(255, 41, 41, 41);
                            })),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Color.fromARGB(
                                    255, 33, 205, 10), //ou color(hexadecimal)
                              ),
                            ),
                            //fixedSize: Size(100,100),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // SingleChildScrollView(child: ,)  ,
                      
                         Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 400,
                            height:350,
                            child: ListView(
                              shrinkWrap:
                                  true, //parametro que faz com que a lista creça a medida que mais itens vao sendo adicionados
                              children: [
                                for (Tarefa titulo in tarefas)
                                  ListaItem(
                                    title: titulo,
                                    onDelet: onDelet,
                                  )
                              ],
                            ),
                          ),
                         ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                'Voce possui ${tarefas.length} tarefas pendentes',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 33, 205, 10),
                                ),
                              )),
                          ElevatedButton(
                            onPressed: confirmacaoDeDeletarTudo,
                            style: ButtonStyle(backgroundColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                    (states) {
                              return Color.fromARGB(255, 41, 41, 41);
                            })),
                            child: Text(
                              'Limpar tudo',
                              style: TextStyle(
                                color: Color.fromARGB(255, 33, 205, 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  void onDelet(Tarefa object) {
    deletedTask = object;
    deletedTaskIndice = tarefas.indexOf(object);
    setState(() {
      tarefas.remove(object);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          shape: Border(
              top: BorderSide(
            color: Color.fromARGB(255, 33, 205, 10),
          )),
          backgroundColor: Colors.black,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'A tarefa ${object.title} foi deletada',
                  style: TextStyle(
                    color: Color.fromARGB(255, 33, 205, 10),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        WidgetStateProperty.resolveWith<Color?>((states) {
                      return Color.fromARGB(255, 41, 41, 41);
                    })),
                    onPressed: () {
                      setState(() {
                        tarefas.insert(deletedTaskIndice!, deletedTask!);
                      });
                      repo.salvarLista(tarefas);

                    },
                    child: Text(
                      'Desfazer',
                      style: TextStyle(
                        color: Color.fromARGB(255, 33, 205, 10),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

confirmacaoDeDeletarTudo(){
     showDialog(
      context: context,
       builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 41, 41, 41),
        title: Text('Deletar todas as tarefas',
        style: TextStyle(color: Color.fromARGB(255, 33, 205, 10),),
        ),
        content: Text('Você tem certeza que deseja deletar todas as tarefas?',
         style: TextStyle(color: Color.fromARGB(255, 33, 205, 10),),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Cancelar',
               style: TextStyle(color: Colors.red),
            )),
          TextButton(
            onPressed: (){
            removeAll(tarefas);
            repo.salvarLista(tarefas);
            Navigator.of(context).pop();
            }, child: Text('Limpar',
            
           style: TextStyle(color: Color.fromARGB(255, 33, 205, 10),),
            )),
            
        ],
       ),
       );
}

  void removeAll(List <Tarefa> value){
     // tarefasDeleted=value!;
      setState(() {
        value.clear();
      });
      repo.salvarLista(tarefas);
  }
}
