import 'package:flutter/material.dart';
class DefaultTextBox extends StatelessWidget {
  final String text;
  final String sectionHead;
  final void Function()? onPressed;
  const DefaultTextBox({
   super.key,
   required this.text,
   required this.sectionHead,
   required this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.lightBlueAccent.shade100,
      ),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(//sectionHead
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionHead,
              style: TextStyle(color: Colors.grey[600]),),
              //edit button
              IconButton(onPressed: onPressed ,
                icon:Icon(Icons.edit), )
            ],
          ),
          //value
          Text(text),
        ],
      ),
    );
  }
}
