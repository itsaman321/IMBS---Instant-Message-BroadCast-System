import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollychat/providers/uc.dart';
import '../providers/Auth.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var isLoading = true;
  TextEditingController clientCode = TextEditingController();
  Map<String, dynamic> user = {};
  var clientList  = [];

  @override
  void initState() {
    user = Provider.of<Auth>(context, listen: false).userData;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<Uc>(context, listen: false).getClient(user['id']);
    clientList =  Provider.of<Uc>(context, listen: false).clients;

    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user['username']}',
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext ctx) {
                    return Container(
                      height: 150,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: clientCode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () async {
                              final addStatus =
                                  await Provider.of<Uc>(context, listen: false)
                                      .addClient(clientCode.text, user['id']);

                              print(addStatus);
                            },
                            child: Text('Add Client'),
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(itemBuilder: (BuildContext context , int index){
            return ListTile(
              title: Text(clientList[index].code),
              subtitle: Text(clientList[index].name) ,
            );
          },itemCount: clientList.length,),
    );
  }
}
