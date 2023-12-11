import 'package:flutter/material.dart';
import 'package:flutter_adaptive_buttons/flutter_adaptive_buttons.dart';
import 'package:get/get.dart';
import 'package:n99_todo_quest/controller/todo_controller.dart';
import 'package:n99_todo_quest/models/todo_model.dart';

class MyTodo extends StatelessWidget {
  int? index;

  MyTodo({this.index});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();
    String text = "";
    text = index == null ? " " : todoController.todoNotes[index!].title;
    TextEditingController textEditingController =
        TextEditingController(text: text);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: index == null
              ? const Text('Create a New Note ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              : const Text('Update note',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Create a new note!!',
                      labelText: ' My Note',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    style: const TextStyle(fontSize: 20),
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AdaptiveElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      color: Colors.red,
                      child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                    ),
                    AdaptiveElevatedButton(
                      onPressed: () {
                        if (index == null) {
                          todoController.todoNotes.add(
                              TodoModel(title: textEditingController.text));
                        } else {
                          var updateTodo = todoController.todoNotes[index!];
                          updateTodo.title = textEditingController.text;
                          todoController.todoNotes[index!] = updateTodo;
                        }

                        Get.back();
                      },
                      color: Colors.green,
                      child: index == null
                          ? const Text('Add',style: TextStyle(color: Colors.white),)
                          : const Text('Update',style: TextStyle(color: Colors.white),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
