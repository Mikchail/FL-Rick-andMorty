import 'package:flutter/material.dart';

class InputSearchName extends StatefulWidget {
  final Function callback;
  InputSearchName({Key? key, required this.callback}) : super(key: key);

  @override
  _InputSearchNameState createState() => _InputSearchNameState();
}

class _InputSearchNameState extends State<InputSearchName> {
  late String searchName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            cursorColor: Colors.grey[200],
            decoration: InputDecoration(
                hintText: "enter name",
                hintStyle: TextStyle(color: Colors.white),
                icon: Icon(Icons.star)),
            onChanged: (value) {
              searchName = value;
            },
          ),
        ),
        TextButton(
          child: Text("Get searchName", style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            widget.callback(searchName);
          },
        )
      ],
    );
  }
}
