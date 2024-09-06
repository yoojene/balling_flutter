import 'dart:convert';
import 'package:flutter/services.dart';

Future<List> readJson({String type = 'sample'}) async {
  String jsonString = 'sample.json';
  String jsonKey = 'users';

  if (type == 'teams') {
    jsonString = 'teams.json';
    jsonKey = 'teams';
  }
  if (type == 'events') {
    jsonString = 'events.json';
    jsonKey = 'events';
  }
  if (type == 'outfits') {
    jsonString = 'events.json';
    jsonKey = 'equipment';
  }
  if (type == 'players') {
    jsonString = 'players.json';
    jsonKey = 'players';
  }

  final String response = await rootBundle.loadString("assets/$jsonString");
  final data = await json.decode(response);
  final jsonData = data[jsonKey];

  return jsonData;
}
