import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:handy/models/events.dart';
import 'package:http/http.dart' as http;

String id = '60aa55c43e452c110c92535b';

String dominio = '26041c28d622.ngrok.io';

bool isOnline = false;

Future<String> getJsonFile() async {
  return await rootBundle.loadString('extra/database_seed.json');
}

Future<Events> getAllEvents() async {
  if (isOnline) {
    var contents = await http.get(Uri.http(dominio, "events"));
    return Events.fromJson(contents.body);
  } else {
    String jsonString = await getJsonFile();
    await Future.delayed(const Duration(milliseconds: 500), () {});
    return Events.fromJson(jsonString);
  }
}

Future<Events> getAllMyEvents() async {
  if (isOnline) {
    var contents = await http
        .get(Uri.http(dominio, "/events", {"participantUser": "$id"}));
    return Events.fromJson(contents.body);
  } else {
    String jsonString = await getJsonFile();
    await Future.delayed(const Duration(milliseconds: 500), () {});
    return Events.fromJson(jsonString);
  }
}

Future postEventSubscription(String eventId) async {
  if (isOnline) {
    await http.put(Uri.http(dominio, "events/$eventId/subscribe"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode({"userId": id}));
  } else {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}

Future deleteEventSubscription(String eventId) async {
  if (isOnline) {
    await http.put(Uri.http(dominio, "events/$eventId/unsubscribe"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: json.encode({"userId": id}));
  } else {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}
