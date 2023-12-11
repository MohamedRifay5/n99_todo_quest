import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:n99_todo_quest/controller/todo_controller.dart';
import 'package:n99_todo_quest/views/my_todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    Widget getTodoList() {
      return Obx(
        () => todoController.todoNotes.isEmpty
            ? const Center(
                child: Center(
                  child: Text('No Data Found'),
                ),
              )
            : ListView.builder(
                itemCount: todoController.todoNotes.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(todoController.todoNotes[index].title,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    leading: Text(
                      "${index + 1}.",
                      style: const TextStyle(fontSize: 15),
                    ),
                    trailing: Wrap(
                      children: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.create),
                            onPressed: () => Get.to(MyTodo(index: index))),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Delete Note',
                              middleText: todoController.todoNotes[index].title,
                              onCancel: () => Get.back(),
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                todoController.todoNotes.removeAt(index);
                                Get.back();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: () {
          Get.to(
            MyTodo(),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: Padding(padding: const EdgeInsets.all(5), child: getTodoList()),
    );
  }
}
