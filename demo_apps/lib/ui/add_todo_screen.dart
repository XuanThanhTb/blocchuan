import 'package:demo_apps/blocs/todos/todos_bloc.dart';
import 'package:demo_apps/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Pattern: Add a To Do'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is AddTodo) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('To Do Added!'),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _inputField('ID', controllerId),
                _inputField('Task', controllerTask),
                _inputField('Description', controllerDescription),
                ElevatedButton(
                  onPressed: () {
                    var todo = Todo(
                        id: controllerId.value.text,
                        task: controllerTask.value.text,
                        description: controllerDescription.value.text);
                    context.read<TodosBloc>().add(
                          AddTodo(todo: todo),
                        );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text('Add To Do'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _inputField(String field, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
