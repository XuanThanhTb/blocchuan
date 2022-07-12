import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;
  Todo(
      {required this.description,
      required this.id,
      this.isCancelled,
      this.isCompleted,
      required this.task}) {
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
        description: description ?? this.description,
        isCancelled: isCancelled ?? this.isCancelled,
        isCompleted: isCompleted ?? this.isCompleted,
        id: id ?? this.id,
        task: task ?? this.task);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, task, description, isCancelled, isCompleted];
  static List<Todo> todos = [
    Todo(description: 'This is a test To Do', id: '1', task: 'Sample ToDo 1'),
    Todo(description: 'This is a test To Do', id: '2', task: 'Sample ToDo 2'),
  ];
}
