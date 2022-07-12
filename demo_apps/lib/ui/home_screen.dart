import 'dart:developer';

import 'package:demo_apps/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:demo_apps/blocs/todos/todos_bloc.dart';
import 'package:demo_apps/call_api/call.dart';
import 'package:demo_apps/models/todo.dart';
import 'package:demo_apps/models/todo_fillter_model.dart';
import 'package:demo_apps/ui/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    debugger();

    super.initState();
  }

  _todoCard(Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          UpdateTodo(
                            todo: todo.copyWith(isCompleted: true),
                          ),
                        );
                  },
                  icon: Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          DeleteTodo(
                            todo: todo,
                          ),
                        );
                  },
                  icon: Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Pending To Dos:"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTodoScreen()));
                  },
                  icon: Icon(Icons.add))
            ],
            bottom: TabBar(
              onTap: (tabIndex) {
                switch (tabIndex) {
                  case 0:
                    BlocProvider.of<TodoFilterBloc>(context)
                        .add(UpdateTodos(todosFilter: TodosFilter.pending));
                    break;
                  case 1:
                    BlocProvider.of<TodoFilterBloc>(context)
                        .add(UpdateTodos(todosFilter: TodosFilter.completed));
                    break;
                }
              },
              tabs: [
                Tab(
                  icon: Icon(Icons.pending),
                ),
                Tab(
                  icon: Icon(Icons.add_task),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            _todos('Pending To Dos'),
            _todos('Completed To Dos'),
          ])),
    );
  }

  BlocBuilder<TodoFilterBloc, TodoFilterState> _todos(String title) {
    return BlocBuilder<TodoFilterBloc, TodoFilterState>(
      builder: (context, state) {
        if (state is TodoFilterLoading) {
          return Container(
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state is TodoFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.filteredTodos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _todoCard(state.filteredTodos[index]);
                    })
              ],
            ),
          );
        } else {
          return Text("Something went wrong!");
        }
      },
    );
  }
}
