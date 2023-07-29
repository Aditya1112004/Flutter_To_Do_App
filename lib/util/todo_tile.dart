import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
      child: Slidable(
        endActionPane: ActionPane(
            motion:StretchMotion() ,
            children: [
              SlidableAction(onPressed:deleteFunction,
              icon:Icons.delete ,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius:1,
                  offset: Offset(0,1),
                  blurStyle: BlurStyle.outer
                )
              ],
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //check box
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor:Colors.green,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                ),
              ),
              SizedBox(width: 15,),
              //task name
              Text(taskName,
              style: TextStyle(
                decoration:taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                  fontWeight:FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black87
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
