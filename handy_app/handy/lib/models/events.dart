import 'dart:convert';

class Events {
  List<Event> events;
  Events({
    required this.events,
  });

  Map<String, dynamic> toMap() {
    return {
      'events': events.map((x) => x.toMap()).toList(),
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      events: List<Event>.from(map['events']?.map((x) => Event.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));
}

class Event {
  String id;
  String url;
  String category;
  DateTime dateTimeStart;
  DateTime dateTimeEnd;
  String title;
  double price;
  String street;
  String place;
  Event({
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

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
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

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
