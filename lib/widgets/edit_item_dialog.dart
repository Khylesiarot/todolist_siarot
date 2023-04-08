import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/todolist_provider.dart';
import '../model/todo_model.dart';

class EditDialogWidget extends StatefulWidget {

  final ToDo toDo;

  const EditDialogWidget({Key? key, required this.toDo}): super(key: key);


  @override
  State<EditDialogWidget> createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  late final TextEditingController _controller;
  late final TextEditingController _descController;

   @override
  void initState() {
    _controller = TextEditingController();
    _descController =TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Todo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Edit Title here',
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Edit Description here',
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
               TextButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final todo = widget.toDo;
                      final editTitle =  _controller.text;
                      final editDesc = _descController.text;

                       context.read<ToDoListProvider>().edit(todo.getID, editTitle, editDesc);
                      const snackBar =
                          SnackBar(content: Text('To Do Item has been editted'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Enter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}