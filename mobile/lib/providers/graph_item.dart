import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:murls/Auth/services/auth_service.dart';

class Graph_item {
  final int count;
  final String date;

  Graph_item({
    required this.count,
    required this.date,
  });
}

//const consturl = "https://695e-2405-201-a003-c1ae-3d41-5632-c8c7-f95.ngrok.io";
const consturl = 'http://52.226.16.59';

class Graph_items with ChangeNotifier {
  List<Graph_item> _graph_details = [];

  List<Graph_item> get items {
    return _graph_details;
  }

  Future<void> fetchAndSetGraph(String id) async {
    //final url = 'GET /_/urls/$id/graph';
    final url = '$consturl/_/urls/$id/graph?filter=7 days';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": 'application/json; charset=UTF-8',
        'Authorization': '${AuthService.instance.auth0AccessToken}',
      },
    );

    final List<Graph_item> loadedgraph = [];

    final extractedGraph = json.decode(response.body);
    if (extractedGraph == null) {
      return;
    }

    for (var urlsData in extractedGraph) {
      loadedgraph
          .add(Graph_item(count: urlsData['count'], date: urlsData['on']));
    }
    _graph_details = loadedgraph.toList();
    notifyListeners();
  }
}
