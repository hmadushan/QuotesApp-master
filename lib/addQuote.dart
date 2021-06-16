import 'package:QuotesApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController author = new TextEditingController();
  TextEditingController category = new TextEditingController();
  TextEditingController quote = new TextEditingController();

  void addQuote() {
    var url = "http://192.168.1.5/Quotes_backend/Services/addQuote.php";
    http.post(url, body: {
      "author": author.text,
      "category": category.text,
      "quote": quote.text,
    });
  }

  Widget _buildAuthorField() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      validator: (text) {
        return HelperValidator.authorValidate(text);
      },
      maxLength: 20,
      maxLines: 1,
      controller: author,
      decoration: InputDecoration(
          labelText: 'AUTHOR',
          hintText: 'Enter author name',
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[850]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.grey[350],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.categoryValidate(text);
      },
      maxLength: 20,
      maxLines: 1,
      controller: category,
      decoration: InputDecoration(
          labelText: 'CATEGORY',
          hintText: 'Enter Category',
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[850]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.grey[350],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  Widget _buildQuoteField() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      maxLines: 3,
      validator: (text) {
        return HelperValidator.quoteValidate(text);
      },
      maxLength: 200,

      controller: quote,
      decoration: InputDecoration(
          labelText: 'QUOTE',
          hintText: 'Enter Quote',
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[850]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.grey[350],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Add Quote Details')),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 150.0,
                      width: 100.0,
                      child: Image(
                        image: AssetImage('assets/quoteslogo.png'),
                      ),
                    ),
                  ),
                  _buildAuthorField(),
                  SizedBox(height: 10),
                  _buildCategoryField(),
                  SizedBox(height: 10),
                  _buildQuoteField(),
                  SizedBox(height: 5.0),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 16.0,
                        ),
                      ),
                      // onPressed: () {
                      //   addFish();
                      //   Navigator.of(context).push(
                      //     new MaterialPageRoute(
                      //       builder: (BuildContext context) => new Home(),
                      //     ),
                      //   );
                      // }),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print('valid form');
                          addQuote();
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Home(),
                            ),
                          );
                          _formKey.currentState.save();
                        } else {
                          print('not valid form');

                          return;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HelperValidator {
  static String authorValidate(String value) {
    if (value.isEmpty) {
      return "author can't be empty";
    }
    if (value.length < 2) {
      return "author must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "author must be less than 50 characters long";
    }
    return null;
  }

  static String categoryValidate(String value) {
    if (value.isEmpty) {
      return "category can't be empty";
    }
    return null;
  }

  static String quoteValidate(String value) {
    if (value.isEmpty) {
      return "Quote can't be empty";
    }
    return null;
  }
}
