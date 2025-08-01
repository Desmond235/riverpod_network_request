import 'package:flutter/material.dart';

@immutable
class Todo {
  final String id;
  final String description;
  final bool isCompleted;
  const Todo({required this.id, required this.description, this.isCompleted = false});

  Todo.fromJson(Map<String, dynamic> json)
    : description = json['description'],
      isCompleted = json['isCompleted'] as bool,
      id = json["id"];

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  Todo copyWith({
    String? id,
    String? description,
    bool? isCompleted
  })  {
    return Todo(
      id:  id ?? this.id,
      description: description ?? this.description
    );
  }  
}
