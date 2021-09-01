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
    print(extractedGraph);

    for (var urlsData in extractedGraph) {
      loadedgraph
          .add(Graph_item(count: urlsData['count'], date: urlsData['on']));
    }
    _graph_details = loadedgraph.toList();
    notifyListeners();
  }
}

DateTime now = DateTime.now();
int currentDay = now.weekday;
DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay + 3));

class Graph_value with ChangeNotifier {
  List<Graph_item> graph = [
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay + 3)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay + 2)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay + 1)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay + 0)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay - 1)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay - 2)).toIso8601String()}'),
    Graph_item(
        count: 0,
        date:
            '${now.subtract(Duration(days: currentDay - 3)).toIso8601String()}'),
  ];

  List<Graph_item> get items {
    return graph;
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
    int i = 0;
    for (var urlsData in extractedGraph) {
      graph[i] = Graph_item(count: urlsData['count'], date: urlsData['on']);
      i++;
    }
  }
}
