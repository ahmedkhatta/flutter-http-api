import 'package:flutter/material.dart';

import 'model/data.dart';

class Detail extends StatefulWidget {
  Data data;

  Detail(this.data);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("application khattab"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.data.url,
                  height: 230.0,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 10.0,
                ),
                new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            child: Text(widget.data.id.toString()),
                          )),
                      SizedBox(
                        height: 6.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(widget.data.title),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
