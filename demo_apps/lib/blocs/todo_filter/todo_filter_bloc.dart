import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_apps/blocs/todos/todos_bloc.dart';
import 'package:demo_apps/models/todo.dart';
import 'package:demo_apps/models/todo_fillter_model.dart';
import 'package:equatable/equatable.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todoSubscription;
  TodoFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodoFilterLoading()) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodos>(_onUpdateTodos);

    _todoSubscription = todosBloc.stream.listen((state) {
      add(const UpdateTodos());
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodoFilterState> emit) {
    if (state is TodoFilterLoading) {
      add(const UpdateTodos(todosFilter: TodosFilter.pending));
    }
    if (state is TodoFilterLoaded) {
      final state = this.state as TodoFilterLoaded;
      add(UpdateTodos(todosFilter: state.todoFilter));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodoFilterState> emit) {
    final state = _todosBloc.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.cancelled:
            return todo.isCancelled!;
          case TodosFilter.pending:
            return !(todo.isCompleted! || todo.isCancelled!);
        }
      }).toList();
    }
  }
}
