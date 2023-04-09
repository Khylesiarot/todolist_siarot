import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist_siarot/Provider/todolist_provider.dart';
import 'package:todolist_siarot/widgets/edit_item_dialog.dart';

import '../model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  final ToDo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (context) => EditDialogWidget(
                      toDo: todo,
                    ),
                    barrierDismissible: false,
                  );
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit'),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                onPressed: (context) {
                  const snackBar =
                      SnackBar(content: Text('To Do item removed'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  context.read<ToDoListProvider>().remove(todo.getID);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete'),
          ],
        ),
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => EditDialogWidget(
            toDo: todo,
          ),
          barrierDismissible: false,
        );
      },
      child: Card(
        elevation: 5,
        shadowColor: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only( left : 10.0),
                child: Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: todo.isDone,
                  onChanged: ((_) async {
                                      context
                                          .read<ToDoListProvider>()
                                          .setTaskComplete(todo.getID);
                                      Future.delayed(
                                          const Duration(milliseconds: 200), () {
                                        context
                                            .read<ToDoListProvider>()
                                            .transferCompleted(todo.getID);
                                        const snackBar = SnackBar(
                                            content: Text('Task completed'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }
                              ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(width: 8),
                    Text(
                      todo.item,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      ),
                      
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
