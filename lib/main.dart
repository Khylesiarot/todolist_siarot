import 'package:flutter/material.dart';
import 'package:todolist_siarot/Provider/todolist_provider.dart';
import 'package:todolist_siarot/widgets/add_dialog.dart';
import 'package:provider/provider.dart';

import 'widgets/todo_list_widget.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ToDoListProvider(),
    child: MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final tabs = [
    Center(
      child: Consumer<ToDoListProvider>(
        builder: (context, value, child) {
          return TodoListWidget();
        },
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),

      body: tabs[selectedIndex],
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) =>
            const AddDialogWidget(),
            barrierDismissible: false,
          );
        
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
