import 'package:flutter/material.dart';
import '../providers/uc.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';

class ClientListTile extends StatelessWidget {
  final String id;
  final String code;
  final String name;

  ClientListTile({required this.code, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).userData;
    return InkWell(
      onTap: () {
        
      },
      child: ListTile(
        title: Text(code),
        subtitle: Text(name),
        trailing: IconButton(
          onPressed: () async {
            final status = await Provider.of<Uc>(context, listen: false)
                .removeClient(user['id'], code);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
