import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'status_enum.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseProvider extends ChangeNotifier {
  static const root = 'http://itx:8888';
  Status _status = Status.init;

  set status(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  Status get status => _status;

  Future<List> get(String what, [String? query]) async {
    final url = Uri.parse('$root/$what?$query');
    debugPrint(url.toString());
    final response = await http.get(url);
    await Future.delayed(const Duration(seconds: 1));

    if (response.statusCode == 200) return jsonDecode(response.body)[what];

    throw Exception(
        'Error getting $what - ${response.statusCode}: ${response.reasonPhrase}');
  }
}
