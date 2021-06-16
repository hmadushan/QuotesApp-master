import 'dart:convert';

List<Quote> quoteFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  Quote({
    this.id,
    this.author,
    this.category,
    this.quote,
  });

  String id;
  String author;
  String category;
  String quote;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        author: json["author"],
        category: json["category"],
        quote: json["quote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "category": category,
        "quote": quote,
      };
}
