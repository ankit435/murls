import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:murls/Auth/services/auth_service.dart';

class Graph_item {
  final int count;
  final int date;

  Graph_item({
    required this.count,
    required this.date,
  });
}

//const consturl = "https://695e-2405-201-a003-c1ae-3d41-5632-c8c7-f95.ngrok.io";
const consturl = 'http://52.226.16.59';

DateTime now = DateTime.now();
int currentDay = now.weekday;
DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay + 3));

class Graph_value with ChangeNotifier {
  List<Graph_item> graph = [
    Graph_item(count: 0, date: 0),
    Graph_item(count: 0, date: 1),
    Graph_item(count: 0, date: 2),
    Graph_item(count: 0, date: 3),
    Graph_item(count: 0, date: 4),
    Graph_item(count: 0, date: 5),
    Graph_item(count: 0, date: 6),
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
      String d = DateFormat.E()
          .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(urlsData['on']));

      switch (d) {
        case 'Sun':
          {
            i = 0;
          }
          break;
        case 'Mon':
          {
            i = 1;
          }
          break;
        case 'Tue':
          {
            i = 2;
          }
          break;
        case 'Wed':
          {
            i = 3;
          }
          break;
        case 'Thu':
          {
            i = 4;
          }
          break;
        case 'Fri':
          {
            i = 5;
          }
          break;
        case 'Sat':
          {
            i = 6;
          }
      }

      graph[i] = Graph_item(count: urlsData['count'], date: i);
    }
  }
}
