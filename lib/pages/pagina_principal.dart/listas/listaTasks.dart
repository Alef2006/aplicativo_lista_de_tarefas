import 'package:aplication_task_list/domain/entities/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListaItem extends StatelessWidget {
  const ListaItem({super.key, required this.title,required this.onDelet});

  final Tarefa title;
  final Function(Tarefa) onDelet;

  @override
  Widget build(BuildContext context) {
    return Slidable(
       key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children:  [
            SizedBox(
              width: 80,
              height: 80,
              child: SlidableAction(
                //  borderRadius: BorderRadius.circular(12),
                borderRadius: BorderRadius.circular(12),
                onPressed:(context) =>onDelet(title) ,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.close_sharp,
              ),
            ),
          ],
        ),
        child: SizedBox(
            width: 400,
            height: 90,
            child: Card(
              color: Color.fromARGB(255, 41, 41, 41),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(title.dateTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 33, 205, 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      title.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 33, 205, 10),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
