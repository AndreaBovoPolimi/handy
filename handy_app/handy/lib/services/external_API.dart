import 'package:handy/models/events.dart';
import 'package:http/http.dart' as http;

String id = '';

// http://example.org/path?q=dart.
//Uri.http("example.org", "/path", { "q" : "dart" });

Future<Events> getAllEvents() async {
  var contents = await http.get(Uri.http("diocane.org", "/events"));
  return Events.fromJson(contents.body);
}

Future<Events> getAllMyEvents() async {
  var contents =
      await http.get(Uri.http("diocane.org", "/events", {"id": "$id"}));
  return Events.fromJson(contents.body);
}

Future postEventSubscription(String eventId) async {
  await http.post(Uri.http(
      "diocane.org", "/events", {"user_id": "$id", "event_id": "$eventId"}));
}

Future deleteEventSubscription(String eventId) async {
  await http.delete(Uri.http(
      "diocane.org", "/events", {"user_id": "$id", "event_id": "$eventId"}));
}
