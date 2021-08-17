import 'package:flutter/material.dart';

class ClientListTile extends StatelessWidget {
  final String id;
  final String code;
  final String name;

  ClientListTile({required this.code, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(code),
      subtitle: Text(name),
      trailing: IconButton(
        onPressed: () {
          print('removed');
        },
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
