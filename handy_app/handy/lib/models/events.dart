import 'dart:convert';

class Events {
  String id;
  String url;
  String category;
  String dateTimeStart;
  String dateTimeEnd;
  String title;
  double price;
  String street;
  String place;
  Events({
    required this.id,
    required this.url,
    required this.category,
    required this.dateTimeStart,
    required this.dateTimeEnd,
    required this.title,
    required this.price,
    required this.street,
    required this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'category': category,
      'dateTimeStart': dateTimeStart,
      'dateTimeEnd': dateTimeEnd,
      'title': title,
      'price': price,
      'street': street,
      'place': place,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      id: map['id'],
      url: map['url'],
      category: map['category'],
      dateTimeStart: map['dateTimeStart'],
      dateTimeEnd: map['dateTimeEnd'],
      title: map['title'],
      price: map['price'],
      street: map['street'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));
}
