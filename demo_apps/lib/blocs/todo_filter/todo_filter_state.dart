part of 'todo_filter_bloc.dart';

abstract class TodoFilterState extends Equatable {
  const TodoFilterState();

  @override
  List<Object> get props => [];
}

class TodoFilterLoading extends TodoFilterState {}

class TodoFilterLoaded extends TodoFilterState {
  final List<Todo> filteredTodos;
  final TodosFilter todoFilter;
  const TodoFilterLoaded(
      {this.todoFilter = TodosFilter.all, required this.filteredTodos});

  @override
  List<Object> get props => [
        filteredTodos,
        todoFilter,
      ];
}
