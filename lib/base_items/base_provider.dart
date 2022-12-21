import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'status_enum.dart';
import '../settings.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseProvider extends ChangeNotifier {
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    Settings.address = prefs.getString('address') ?? 'itx';
    Settings.port = prefs.getInt('port') ?? 8888;
  }

  Status _status = Status.init;

  set status(Status newStatus) {
    _status = newStatus;
    notifyListeners();
  }

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

    return [];
  }
}
