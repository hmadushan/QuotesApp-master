import 'package:QuotesApp/Quote.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'addQuote.dart';
import 'editQuote.dart';

void main() => runApp(new MaterialApp(
      title: "My Quotes",
      home: new Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Quote>> fetchQuotes() async {
    final response = await http
        .get("http://192.168.1.5/Quotes_backend/Services/getQuote.php");

    return quoteFromJson(response.body);
  }

  void deleteData(String _id) async {
    print(_id);
    var url = "http://192.168.1.5/Quotes_backend/Services/deleteQuote.php";
    print(_id);
    var data = {"id": _id};
    var res = await http.post(url, body: data);
    print(res);
  }

  Future confirmAndDetele(context, String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            new RaisedButton(
              child: Text(
                "Delete",
                style: new TextStyle(color: Colors.red),
              ),
              color: Colors.white,
              onPressed: () {
                deleteData(id);
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Home(),
                  ),
                );
              },
            ),
            new RaisedButton(
              child: Text(
                "Cancel",
                style: new TextStyle(color: Colors.black),
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // void confirm(String id) {
  //   print(id);
  //   AlertDialog alertDialog = new AlertDialog(
  //     content: Text("Are you sure you want to delete this item?"),
  //     actions: <Widget>[
  //       new RaisedButton(
  //         child: Text(
  //           "Delete",
  //           style: new TextStyle(color: Colors.red),
  //         ),
  //         color: Colors.white,
  //         onPressed: () {
  //           deleteData(id);
  //           Navigator.of(context).push(
  //             new MaterialPageRoute(
  //               builder: (BuildContext context) => new Home(),
  //             ),
  //           );
  //         },
  //       ),
  //       new RaisedButton(
  //         child: Text(
  //           "Cancel",
  //           style: new TextStyle(color: Colors.black),
  //         ),
  //         color: Colors.white,
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ],
  //   );

  //   showDialog(context: context, child: alertDialog);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(
          "Quotes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ),
        ),
        child: new Icon(
          Icons.add,
          color: Colors.grey[200],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: new FutureBuilder<List>(
            future: fetchQuotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length < 1) {
                  return Center(
                    child: Image(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/nodata.JPG"),
                    ),
                  );
                } else
                  return Column(children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 150.0,
                      child: Image(
                        image: AssetImage('assets/quoteslogo.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          Quote quote = snapshot.data[index];
                          String id = "${quote.id}";

                          var au = "${quote.author}";
                          String cat = "${quote.category}";
                          String quo = "${quote.quote}";

                          return Column(children: <Widget>[
                            // Divider(
                            //   color: Colors.blue[900],
                            //   thickness: 1.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Colors.grey[300],
                                    Colors.grey[350],
                                    Colors.grey
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )),
                                child: ListTile(
                                  hoverColor: Colors.blueGrey[400],
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 10),
                                    child: Text(
                                      '${quote.author}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0),
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Category: ${quote.category} ",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: new Icon(
                                    Icons.format_quote,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Description(
                                        author: au,
                                        category: cat,
                                        quote: quo,
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20.0,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Edit(
                                                id: id,
                                                author: au,
                                                category: cat,
                                                quote: quo,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20.0,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          confirmAndDetele(context, id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            // Divider(
                            //   color: Colors.blue[900],
                            //   thickness: 1.0,
                            // )
                          ]);
                        },
                      ),
                    ),
                  ]);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  final String author;
  final String category;
  final String quote;

  Description({Key key, this.author, this.category, this.quote})
      : super(key: key);
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "${widget.author}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: <Widget>[
              Container(
                height: 270.0,
                width: 200.0,
                child: Image(
                  image: AssetImage('assets/quoteslogo.png'),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ExpansionCard(
                    borderRadius: 20,
                    background: Image.asset(
                      "assets/card.JPG",
                      fit: BoxFit.cover,
                    ),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            "${widget.author}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Category: ${widget.category} ",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Text("Quote:  ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        child: Text(" ' ${widget.quote}.' ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
