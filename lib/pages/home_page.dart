import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox=Hive.box('mybox');
  TodoDatabase db= TodoDatabase();

  @override
  void initState() {
    //if this is the 1st time ever opening create default data
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }
    else{
      //there alreasy exitsts data
      db.loadData();
    }
    super.initState();

  }

  //text controller
  final _controller= TextEditingController();

  //list of tasks
  // List toDolist=[
  //   // ["make tut",false],
  //   // ["new make tut",false],
  // ];

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDolist.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

   //create new task 
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
            controller:_controller ,
            onSave: saveNewTask,
            onCancel: ()=>Navigator.of(context).pop(),
          );
        },

    );
  }

  void checkBoxChanged(bool? value, int index){
  setState(() {
    db.toDolist[index][1]= !db.toDolist[index][1];
  });
  db.updateDatabase();
  }

  void deleteTask(int index){
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("All Tasks",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDolist[index][0],
            taskCompleted:db.toDolist[index][1] ,
            onChanged:(value) => checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
