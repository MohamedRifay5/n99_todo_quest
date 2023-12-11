
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:n99_todo_quest/models/todo_model.dart';


class TodoController extends GetxController{
  var todoNotes = <TodoModel>[].obs;

  void add(TodoModel todoModel) {
    todoNotes.add(todoModel);
  }
  @override
  void onInit() {
    List? storedTodo=GetStorage().read<List>('todo_box');
    if(!storedTodo.isNull){
      todoNotes=storedTodo!.map((e) => TodoModel.fromJson(e)).toList().obs;
    }
    ever(todoNotes, (_){
      GetStorage().write('todo_box',todoNotes.toList());
    });
    super.onInit();
  }
}
