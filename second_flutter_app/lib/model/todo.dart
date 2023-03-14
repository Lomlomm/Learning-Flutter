import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoText; 
  bool isDone; 

  ToDo({
    required this.id, 
    required this.todoText, 
    this.isDone = false
  });

  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Finish data analytics with Google', isDone: false), 
      ToDo(id: '02', todoText: 'Prepare Exoplanets ANN presentation', isDone: false), 
      ToDo(id: '03', todoText: 'Shower la nena', isDone: false),
      ToDo(id: '04', todoText: 'Find a job', isDone: false),
      ToDo(id: '05', todoText: 'Take CI/CD course', isDone: false),
      ToDo(id: '06', todoText: 'Journaling', isDone: false) 

    ];

  }
}