import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'status_enum.dart';
import '../settings.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseProvider extends ChangeNotifier {
  Status _status = Status.init;

  set status(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  void init() async {}

  Status get status => _status;

  Future<List> get(String what, [String? query]) async {
    final url = Uri.parse('${Settings.root}/$what?$query');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) return jsonDecode(response.body)[what];

      throw Exception(
          'Error getting $what - ${response.statusCode}: ${response.reasonPhrase}');
    } catch (e) {
      rethrow;
    }
  }
}
