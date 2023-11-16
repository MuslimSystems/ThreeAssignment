import 'package:assignmentthree/screen/model/todomodel.dart';
import 'package:assignmentthree/screen/todolistprovider.dart';
import 'package:flutter/material.dart';

class ProviderTodo extends StatefulWidget {
  const ProviderTodo({super.key});

  @override
  State<ProviderTodo> createState() => _ProviderTodo();
}

class _ProviderTodo extends State<ProviderTodo> {
  final _todoText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = TodolistProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Todo List Provider'),
      ),
      body:  Column(
        children: [
          const Text("incompleteTodos"),
          todoListTodo(provider.incompleteTodos),
          const Text("completedTodos"),
         _todoListTodo(provider.completedTodos),
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
                    if (_formKey.currentState!.validate()) {
                      provider.addTodo(_todoText.text)
                    }
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
    final provider = TodolistProvider.of(context);
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
                              provider.addcompletedTodos(incompleteTodos[index].title,incompleteTodos[index].isDone);
                              incompleteTodos[index].isDone = value!;
                              provider.removeIndex(index);
                          },
                        ),
                        title: Text(incompleteTodos[index].title),
                        trailing: IconButton(
                          // iconSize: 72,
                          icon: const Icon(Icons.delete_forever_outlined),
                          onPressed: () {
                            provider.removeIndex(index);
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
    final provider = TodolistProvider.of(context);
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
                           
                              provider.addIncompletedTodos(completedTodos[index].title,completedTodos[index].isDone);
                              completedTodos[index].isDone = value!;
                              provider.removeIndexcompletedTodos(index);
                          
                  
                          },
                        ),
                        title: Text(completedTodos[index].title),
                        trailing: IconButton(
                          // iconSize: 72,
                          icon: const Icon(Icons.delete_forever_outlined),
                          onPressed: () {
                           provider.removeIndexcompletedTodos(index);
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
