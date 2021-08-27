import 'dart:io';

import 'package:flutter/material.dart';
import './murls_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:murls/Auth/models/auth0_user.dart';
import 'package:murls/Auth/services/auth_service.dart';

class murls_detail with ChangeNotifier {
  List<Murls> _items = [
    // Murls(
    //     Alias: 'ankit',
    //     murlsUrl: 'ebewe',
    //     datetime: DateTime.now().toIso8601String(),
    //     click: 0,
    //     Id: 2.toString())
  ];

  List<Murls> get items {
    return _items;
  }

  Murls findById(String id) {
    return _items.firstWhere((urls) => urls.Id == id);
  }

  Future<void> addUrls(Murls murls) async {
    Auth0User? profile = AuthService.instance.profile;
    // final url =
    //     'https://murls-4a35c-default-rtdb.firebaseio.com/murls/${profile?.id}.json';
    const url = 'http://52.226.16.59/_/urls';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': murls.Alias,
          'location': murls.murlsUrl,
          'description': murls.datetime,
          // 'slug': murls.click,
          'boosted': murls.boost,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 201) {
        final newURls = Murls(
          Alias: murls.Alias,
          murlsUrl: murls.murlsUrl,
          datetime: murls.datetime,
          click: murls.click,
          boost: murls.boost,
          Id: json.decode(response.body)['id'].toString(),
        );
        _items.add(newURls);
      } else {
        throw Exception('Failed to add urls');
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetUrls() async {
    Auth0User? profile = AuthService.instance.profile;
    // final url =
    //     'https://murls-4a35c-default-rtdb.firebaseio.com/murls/${profile?.id}.json';
    const url = 'http://52.226.16.59/_/urls';

    try {
      final response = await http
          .get(Uri.parse(url), headers: {"Accept": "application/json"});

      final extractedData = json.decode(response.body);

      final List<Murls> loadedUrls = [];

      if (extractedData == null) {
        return;
      }
      for (var urlsData in extractedData) {
        loadedUrls.add(Murls(
          Id: urlsData['id'].toString(),
          Alias: urlsData['name'],
          murlsUrl: urlsData['location'],
          datetime: urlsData['description'],
          boost: urlsData['boosted'],
          click: urlsData['clicks'],
        ));
      }

      _items = loadedUrls.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateUrls(String Id, Murls newURLS) async {
    final UrlIndex = _items.indexWhere((Url) => Url.Id == Id);
    final url = 'http://52.226.16.59/_/urls/$Id';
    if (UrlIndex >= 0) {
      final Response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'name': newURLS.Alias,
          'location': newURLS.murlsUrl,
          'description': newURLS.datetime,
          // 'slug': murls.click,
          'boosted': newURLS.boost,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (Response.statusCode == 200) {
        _items[UrlIndex] = newURLS;
        notifyListeners();
      } else {
        throw Exception('Failed to get user details');
      }
    } else {
      print('no update');
    }
  }

  Future<void> removeItem(String urlId) async {
    Auth0User? profile = AuthService.instance.profile;
    final url = 'http://52.226.16.59/_/urls/$urlId';
    final existingurlindex = _items.indexWhere((url) => url.Id == urlId);
    Murls? existingurl = _items[existingurlindex];
    _items.removeAt(existingurlindex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode >= 400) {
      _items.insert(existingurlindex, existingurl);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingurl = null;
  }
}
