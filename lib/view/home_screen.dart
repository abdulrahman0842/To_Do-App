import 'package:flutter/material.dart';
import 'package:to_do_app/models/to_do_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiService = ApiService();
  final titleController = TextEditingController();
  List<ToDoModel>? todos;
  @override
  void initState() {
    loadToDo();
    super.initState();
  }

  void loadToDo() async {
    todos = await apiService.getToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ToDo App")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add a ToDo"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: "Title"),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                bool response = await apiService
                                    .addToDo(titleController.text);
                                todos!.add(ToDoModel(
                                    id: 8,
                                    title: titleController.text,
                                    completed: false));
                                ScaffoldMessenger(
                                    child: SnackBar(
                                        content: Text(response
                                            ? "Addedd Successfully"
                                            : "Unable to add")));
                                Navigator.pop(context);
                              },
                              child: Text("Add ToDo"))
                        ],
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: todos == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: todos?.length ?? 0,
                itemBuilder: (context, index) {
                  ToDoModel todo = todos![index];
                  return ListTile(
                      leading: IconButton(
                          onPressed: () {
                            setState(() {
                              todos![index].completed =
                                  !todos![index].completed;
                            });
                          },
                          icon: todo.completed
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank)),
                      title: Text(todo.title),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              todos!.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete)));
                })
        
        );
  }
}
