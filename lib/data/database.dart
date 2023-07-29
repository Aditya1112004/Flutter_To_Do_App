import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase{

  List toDolist=[];

  //reference our box
  final _myBox=Hive.box('mybox');

  //run this method 1st time ever opening this app
  void createInitialData(){
    toDolist=[
      ['Aditya Kumawat',false],
      ['To Do App',false],
    ];
  }

  //load data from db
  void loadData(){
    toDolist=_myBox.get('TODOLIST');
  }

  //update db
  void updateDatabase(){
    _myBox.put("TODOLIST", toDolist);
  }


}