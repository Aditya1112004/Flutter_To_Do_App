import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller:controller ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
          SizedBox(height: 10,),
          //  buttons  save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //save button

                MyButton(text: "Save", onPressed: onSave,),
              SizedBox(width: 8,),
              //  cancel button
                MyButton(text: "Cancel", onPressed: onCancel,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
