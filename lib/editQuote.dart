import 'package:flutter/material.dart';
import 'package:QuotesApp/main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final String author;
  final String category;
  final String quote;
  final String id;
  Edit({Key key, this.id, this.author, this.category, this.quote})
      : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController qid;
  TextEditingController qauthor;
  TextEditingController qcategory;
  TextEditingController qquote;
  void editData() {
    var url = "http://192.168.1.5/Quotes_backend/Services/editQuote.php";

    http.post(url, body: {
      "id": qid.text,
      "author": qauthor.text,
      "category": qcategory.text,
      "quote": qquote.text,
    });
    print(qid.text);
  }

  void initState() {
    qid = new TextEditingController(text: "${widget.id}");
    qauthor = new TextEditingController(text: "${widget.author}");
    qcategory = new TextEditingController(text: "${widget.category}");
    qquote = new TextEditingController(text: "${widget.quote}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: Text("Edit Quote Details"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 150.0,
                  child: Image(
                    image: AssetImage('assets/quoteslogo.png'),
                  ),
                ),
                // new TextField(
                //   controller: bid,
                //   decoration: new InputDecoration(
                //     hintText: "UID",
                //     labelText: "UID",
                //   ),
                // ),
                new TextField(
                  controller: qauthor,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                      // hoverColor: Colors.lightBlue[800],
                      //border: OutlineInputBorder(),
                      hintText: "AUTHOR",
                      labelText: "author",
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey[850]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.grey[350],
                      filled: true),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: qcategory,
                  style: TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      hintText: "Category",
                      labelText: "CATEGORY",
                      //hoverColor: Colors.lightBlue[800],
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey[850]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.grey[350],
                      filled: true),
                ),

                SizedBox(height: 10),
                new TextField(
                  style: TextStyle(color: Colors.black),
                  maxLines: 3,
                  controller: qquote,
                  decoration: new InputDecoration(
                      hintText: " Enter Quote",
                      labelText: "QUOTE",
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.grey[850]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.grey[350],
                      filled: true),
                ),

                new Padding(padding: EdgeInsets.all(10.0)),
                new RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Home(),
                      ),
                    );
                  },
                  child: new Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
