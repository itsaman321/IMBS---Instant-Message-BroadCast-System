import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/message.dart' show MessageProvider;
import 'package:http/http.dart' as http;

class MessageBoard extends StatefulWidget {
  const MessageBoard({Key? key}) : super(key: key);

  @override
  _MessageBoardState createState() => _MessageBoardState();
}

class _MessageBoardState extends State<MessageBoard> {
  List msgList = [];

  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)!.settings.arguments as Map;
    msgList = Provider.of<MessageProvider>(context, listen: false).limitMessage;

    return Scaffold(
      appBar: AppBar(
        title: Text(client['name']),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 3 / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text(msgList[index].clientcode),
              subtitle: Text(msgList[index].message),
              trailing: Text(msgList[index].time),
            ),
          );
        },
        itemCount: msgList.length,
      ),
    );
  }
}
