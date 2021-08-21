import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rollychat/providers/uc.dart';
import '../providers/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/client_widget.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var isLoading = true;
  TextEditingController clientCode = TextEditingController();
  Map<String, dynamic> user = {};
  var clientList = [];

  @override
  void initState() {
    user = Provider.of<Auth>(context, listen: false).userData;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<Uc>(context).getClient(user['id']);
    clientList = Provider.of<Uc>(context, listen: false).clients;
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Building');
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
                              labelText: 'Client Code',
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () async {
                              final addStatus =
                                  await Provider.of<Uc>(context, listen: false)
                                      .addClient(clientCode.text, user['id']);

                              setState(() {});
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
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              if (prefs.getString('status') != '') {
                prefs.remove('status');
              }
              Navigator.of(context).pushReplacementNamed('/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Uc>(
              builder: (_, value, child) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ClientListTile(
                        id: clientList[index].id,
                        code: clientList[index].code,
                        name: clientList[index].name);
                  },
                  itemCount: clientList.length,
                );
              },
            ),
    );
  }
}
