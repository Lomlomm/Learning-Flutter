import 'package:flutter/material.dart';
import 'package:second_flutter_app/model/todo.dart';
import 'package:second_flutter_app/constants/colors.dart';

class ToDoItem extends StatelessWidget{
  final ToDo todo;
  final onToDoChanged; 
  final onDeleteItem;

  const ToDoItem ({super.key, required this.todo, required this.onToDoChanged, required this.onDeleteItem});
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
      onTap: () {
        onToDoChanged(todo);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank, 
          color: tdPurple,
          ),
        title: Text(
          todo.todoText!, 
          style: TextStyle(
            fontSize: 16, 
            color: tdPurpleB, 
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              color: Colors.white, 
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                onDeleteItem(todo.id);
              },
              ),
          ),
      ),
    );
  }
}