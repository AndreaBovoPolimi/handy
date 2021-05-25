import 'dart:convert';

class Events {
  bool result;
  List<Event> events;
  Events({
    required this.result,
    required this.events,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'data': events.map((x) => x.toMap()).toList(),
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      result: map['result'],
      events: List<Event>.from(map['data'].map((x) => Event.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));
}

class Event {
  String sId;
  String title;
  DateTime datetimeStart;
  DateTime datetimeEnd;
  String thumbMediaUrl;
  String category;
  Location location;
  int ticketCost;
  Event({
    required this.sId,
    required this.title,
    required this.datetimeStart,
    required this.datetimeEnd,
    required this.thumbMediaUrl,
    required this.category,
    required this.location,
    required this.ticketCost,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': sId,
      'title': title,
      'datetimeStart': datetimeStart,
      'datetimeEnd': datetimeEnd,
      'thumbMediaUrl': thumbMediaUrl,
      'category': category,
      'location': location.toMap(),
      'ticketCost': ticketCost,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      sId: map['_id'],
      title: map['title'],
      datetimeStart: DateTime.parse(map['datetimeStart']),
      datetimeEnd: DateTime.parse(map['datetimeEnd']),
      thumbMediaUrl: map['thumbMediaUrl'],
      category: map['category'],
      location: Location.fromMap(map['location']),
      ticketCost: map['ticketCost'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}

class Location {
  String title;
  String address;
  Location({
    required this.title,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'address': address,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      title: map['title'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));
}
