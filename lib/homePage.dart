import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './model/data.dart';
import 'drtails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MaterialColor> _color = [
    Colors.teal,
    Colors.lightBlue,
    Colors.green,
    Colors.blue,
    Colors.lightGreen,
    Colors.cyan,
    Colors.red,
    Colors.orange,

  ];
  Future<List<Data>> getAllData() async {
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data = await http.get(api);
    var jsonData = json.decode(data.body);
    List<Data> listof = [];
    for (var i in jsonData) {
      Data data = new Data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      listof.add(data);
    }
    return listof;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("application khattab"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), onPressed: () => debugPrint("search")),
          IconButton(icon: Icon(Icons.add), onPressed: () => debugPrint("add")),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Ahmed Khattab"),
              accountEmail: Text("akhattab595@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: new Text("first Page"),
              leading: new Icon(
                Icons.search,
                color: Colors.orange,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: new Text("ADD"),
              leading: new Icon(
                Icons.add,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: new Text("third Page"),
              leading: new Icon(
                Icons.title,
                color: Colors.purple,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: new Text("fourth Page"),
              leading: new Icon(
                Icons.list,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: new Text("Close"),
              leading: new Icon(
                Icons.close,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapShote) {
                if (snapShote.data == null) {
                  return Center(
                    child: Text("Loding Data...?"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapShote.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext c, int index) {
                      MaterialColor mColor = _color[index % _color.length];
                      return Card(
                        elevation: 10.0,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              snapShote.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            new SizedBox(
                              height: 7.0,
                            ),
                            new Container(
                              margin: EdgeInsets.all(5.0),
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: mColor,
                                      child: Text(
                                          snapShote.data[index].id.toString()),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    child: new Text(
                                      snapShote.data[index].title,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapShote) {
                  if (snapShote.data == null) {
                    return Center(
                      child: Text("Loding Data...?"),
                    );
                  }
                  else{
                    return ListView.builder(

                        itemCount: snapShote.data.length,
                        itemBuilder: (BuildContext c, int index) {
                          MaterialColor mColor = _color[index % _color.length];
                          return Card(
                            elevation: 7.0,
                            child: Container(
                              height: 100.0,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      snapShote.data[index].url,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      child: Text(
                                        snapShote.data[index].title,
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c)=>Detail(snapShote.data[index])));
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        child: Text(snapShote.data[index].id.toString(),
                                        ),
                                        backgroundColor: mColor,
                                        foregroundColor: Colors.white,
                                      ),




                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ))
        ],
      ),
    );
  }
}
