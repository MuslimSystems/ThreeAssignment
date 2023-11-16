import 'package:assignmentthree/screen/model/todomodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TodolistProvider extends ChangeNotifier {
  
   List<Todo> incompleteTodos = []; 
  List<Todo> completedTodos = [];

void addTodo(String addTodotext) {
    
    incompleteTodos.add(Todo(title: addTodotext));
    notifyListeners();
  }

  void removeIndex(int index) {
      incompleteTodos.removeAt(index);
      notifyListeners();
  }

  removeIndexcompletedTodos(index){
    completedTodos.removeAt(index);
     notifyListeners();
  }
  
  addcompletedTodos(String title, bool isDone) {
      completedTodos.add(Todo(title: title , isDone: true));
      notifyListeners();
  }
  addIncompletedTodos(String title, bool isDone) {
      incompleteTodos.add(Todo(title: title , isDone: false));
      notifyListeners();
  }

  static TodolistProvider of(
    BuildContext context,{
      bool listen = true,
    })
    {
      return Provider.of<TodolistProvider>(
        context,
        listen: listen,
      );
    }
}
