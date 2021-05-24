import 'package:handy/models/events.dart';
import 'package:http/http.dart' as http;

String id = '';

bool isOnline = false;

Event event1 = Event(
    id: "1234",
    url: "https://i.postimg.cc/tTX3tgFx/conference.png",
    category: "Conference",
    dateTimeStart: DateTime.now(),
    dateTimeEnd: DateTime.now(),
    title: "Inside the mind of a master procrastinator | Tim Urban",
    price: 1,
    street: "via cavalleggeri treviso 13",
    place: "natta merda");

Event event2 = Event(
    id: "12345",
    url: "https://i.postimg.cc/CKy2Hbv6/2021-05-23-20-36-04.jpg",
    category: "Workshop",
    dateTimeStart: DateTime.now(),
    dateTimeEnd: DateTime.now(),
    title: "Sustainability and the role of Ecosystems",
    price: 13,
    place: "Politecnico di Milano",
    street: "Piazza Leonardo da Vinci 3");

Event event3 = Event(
    id: "12346",
    url: "https://i.postimg.cc/zGLmkzq3/2021-05-23-20-36-08.jpg",
    category: "Music",
    dateTimeStart: DateTime.now(),
    dateTimeEnd: DateTime.now(),
    title: "Vivaldi's four seasons",
    price: 37,
    street: "Via Filodrammatici, 2, 20121 Milano MI",
    place: "Teatro alla Scala");

Events events = Events(events: [event1, event2, event3]);
// http://example.org/path?q=dart.
//Uri.http("example.org", "/path", { "q" : "dart" });

Future<Events> getAllEvents() async {
  if (isOnline) {
    var contents = await http.get(Uri.http("diocane.org", "/events"));
    return Events.fromJson(contents.body);
  } else {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    return events;
  }
}

Future<Events> getAllMyEvents() async {
  if (isOnline) {
    var contents =
        await http.get(Uri.http("diocane.org", "/events", {"id": "$id"}));
    return Events.fromJson(contents.body);
  } else {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    return events;
  }
}

Future postEventSubscription(String eventId) async {
  if (isOnline) {
    await http.post(Uri.http(
        "diocane.org", "/events", {"user_id": "$id", "event_id": "$eventId"}));
  } else {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}

Future deleteEventSubscription(String eventId) async {
  if (isOnline) {
    await http.delete(Uri.http(
        "diocane.org", "/events", {"user_id": "$id", "event_id": "$eventId"}));
  } else {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}
