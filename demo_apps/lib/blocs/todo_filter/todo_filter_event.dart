part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodoFilterEvent {
  const UpdateFilter();

  @override
  List<Object> get props => [];
}

class UpdateTodos extends TodoFilterEvent {
  final TodosFilter todosFilter;
  const UpdateTodos({this.todosFilter = TodosFilter.all});

  @override
  List<Object> get props => [todosFilter];
}
