import 'package:assignmentthree/screen/model/todomodel.dart';
import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _Todolist();
}

class _Todolist extends State<Todolist> {
  final _formKey = GlobalKey<FormState>();
  //List<Todo> todos = [];

  List<Todo> incompleteTodos = []; 
  List<Todo> completedTodos = [];

  final _todoText = TextEditingController();


  void addTodo() {
    setState(() {
      incompleteTodos.add(Todo(title: _todoText.text));
      //_todoText.clear();
    });
  }

  void removeIndex(int index) {
    //if (index) {
    setState(() {
      incompleteTodos.removeAt(index);
    });
    //}
  }

  removeIndexcompletedTodos(index){
    setState(() {
      completedTodos.removeAt(index);
    });
  }
  
  addcompletedTodos(String title, bool isDone) {
    setState(() {
      completedTodos.add(Todo(title: title , isDone: true));
      _todoText.clear();
    });
  }

  addIncompletedTodos(String title, bool isDone) {
    setState(() {
      incompleteTodos.add(Todo(title: title , isDone: false));
      _todoText.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Todo List SetState'),
      ),
      body:  Column(
        children: [
          const Text("incompleteTodos"),
          todoListTodo(incompleteTodos),
          const Text("completedTodos"),
         _todoListTodo(completedTodos),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _todoText,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // Change the border color here
                      ),
                      hintText: 'Todo',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () => {
                    if (_formKey.currentState!.validate()) {addTodo()}
                  },
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded todoListTodo(List<Todo> incompleteTodos) {
    return Expanded(
          child: ListView.builder(
            itemCount: incompleteTodos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Colors.grey,
                      child: ListTile(
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: incompleteTodos[index].isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              addcompletedTodos(incompleteTodos[index].title,incompleteTodos[index].isDone);
                              incompleteTodos[index].isDone = value!;
                              removeIndex(index);
                            });
                          },
                        ),
                        title: Text(incompleteTodos[index].title),
                        trailing: IconButton(
                          // iconSize: 72,
                          icon: const Icon(Icons.delete_forever_outlined),
                          onPressed: () {
                            removeIndex(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
  }
  Expanded _todoListTodo(List<Todo> completedTodos) {
    return Expanded(
          child: ListView.builder(
            itemCount: completedTodos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Colors.grey,
                      child: ListTile(
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.black,
                          value: completedTodos[index].isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              addIncompletedTodos(completedTodos[index].title,completedTodos[index].isDone);
                              completedTodos[index].isDone = value!;
                              removeIndexcompletedTodos(index);
                            });
                  
                          },
                        ),
                        title: Text(completedTodos[index].title),
                        trailing: IconButton(
                          // iconSize: 72,
                          icon: const Icon(Icons.delete_forever_outlined),
                          onPressed: () {
                            removeIndexcompletedTodos(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
}
