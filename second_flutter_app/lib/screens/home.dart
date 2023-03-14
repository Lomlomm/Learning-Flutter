import 'package:flutter/material.dart';
import 'package:second_flutter_app/model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget{
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();


  @override

  void initState(){
    _foundToDo = todosList;
    super.initState();
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 20),
                        child: Text(
                          'All ToDos', 
                          style: TextStyle(
                            fontSize: 30, 
                            fontWeight: 
                            FontWeight.w500,
                            ),
                          ),
                      ),
                      for(ToDo todo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todo, 
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: _deleteToDoItem,)
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:EdgeInsets.only(
                    bottom: 20, 
                    right: 20, 
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 5),
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0,0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0, 
                      ),],
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                        decoration: InputDecoration(
                          hintText: 'Add new ToDo item',
                          border: InputBorder.none
                        ),
                      ), 
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20, 
                ),
                child: ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 35,),),
                  onPressed: (){
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdPurpleB,
                    minimumSize: Size(5, 10),
                    elevation: 10,
                  ),
                  ),
              )
            ]),
          ),
        ],
      ),
  
    );
  }

  void handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;    
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(ToDo(
      id: DateTime.now().microsecondsSinceEpoch.toString(), 
      todoText: toDo,
      ));
    });
    _todoController.clear();
  }
  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todosList;
    }
    else{
    results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }
  setState(() {
    _foundToDo = results;
  });

  } 

  Widget searchBox(){
    return Container(
              padding: EdgeInsets.symmetric(horizontal:20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search, 
                    color: tdPurpleB,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20, 
                    minWidth: 25
                    ),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: tdGrey)
                  ),
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu, 
          color: tdPurpleB,
          size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.png') 
              ),
          )
      ]),
    );
  }
}