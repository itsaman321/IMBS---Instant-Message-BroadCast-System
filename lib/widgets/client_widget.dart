import 'package:flutter/material.dart';
import 'package:rollychat/providers/message.dart';
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
      onTap: () async {
        await Provider.of<MessageProvider>(context, listen: false)
            .getMessages(code);
        Navigator.of(context).pushNamed('/messageBoard', arguments: {
          'code': code,
          'name': name,
        });
      },
      child: Consumer<Uc>(builder: (ctx, child, value) {
        return ListTile(
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
        );
      }),
    );
  }
}
