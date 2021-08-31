import 'dart:io';

import 'package:flutter/material.dart';

import './murls_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:murls/Auth/services/auth_service.dart';

//const consturl = "https://695e-2405-201-a003-c1ae-3d41-5632-c8c7-f95.ngrok.io";
const consturl = 'http://52.226.16.59';

// ignore: camel_case_types
class murls_detail with ChangeNotifier {
  List<Murls> _items = [];

  List<Murls> get items {
    return _items;
  }

  Murls findById(String id) {
    return _items.firstWhere((urls) => urls.Id == id);
  }

  List<Murls> findByAlias(String Alias) {
    return _items
        .where((urls) => urls.Alias.contains(Alias.toLowerCase()))
        .toList();
  }

  Future<void> addUrls(Murls murls) async {
    const url = '$consturl/_/urls';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': murls.Alias,
          'location': murls.murlsUrl,
          'expiry_date': murls.Expirydatetime,
          'boosted': murls.boost,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${AuthService.instance.auth0AccessToken}',
        },
      );

      if (response.statusCode == 201) {
        final newURls = Murls(
          Alias: murls.Alias,
          murlsUrl: murls.murlsUrl,
          UserURl: json.decode(response.body)['shortened'].toString(),
          Createddatetime: json.decode(response.body)['created_at'],
          Expirydatetime: murls.Expirydatetime,
          click: murls.click,
          boost: murls.boost,
          Id: json.decode(response.body)['id'].toString(),
        );

        _items.insert(0, newURls);
      } else {
        throw Exception('Failed to add urls');
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetUrls() async {
    const url = '$consturl/_/urls';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": 'application/json; charset=UTF-8',
          'Authorization': '${AuthService.instance.auth0AccessToken}',
        },
      );

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
          Expirydatetime: urlsData['expiry_date'],
          boost: urlsData['boosted'],
          click: urlsData['clicks'],
          Createddatetime: urlsData['created_at'],
          UserURl: urlsData['shortened'],
        ));
      }

      _items = loadedUrls.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> updateUrls(String Id, Murls newURLS) async {
    // ignore: non_constant_identifier_names
    final UrlIndex = _items.indexWhere((Url) => Url.Id == Id);
    final url = '$consturl/_/urls/$Id';
    if (UrlIndex >= 0) {
      // ignore: non_constant_identifier_names
      final Response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'name': newURLS.Alias,
          'location': newURLS.murlsUrl,
          'expiry_date': newURLS.Expirydatetime,
          'boosted': newURLS.boost,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${AuthService.instance.auth0AccessToken}',
        },
      );

      if ((Response.statusCode == 200)) {
        _items[UrlIndex] = newURLS;
        notifyListeners();
      } else {
        //throw Exception('Failed to get user details');
      }
    } else {}
  }

  Future<void> removeItem(String urlId) async {
    final url = '$consturl/_/urls/$urlId';
    final existingurlindex = _items.indexWhere((url) => url.Id == urlId);
    Murls? existingurl = _items[existingurlindex];
    _items.removeAt(existingurlindex);
    notifyListeners();

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${AuthService.instance.auth0AccessToken}',
      },
    );
    if (response.statusCode >= 400) {
      _items.insert(existingurlindex, existingurl);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingurl = null;
  }
}

class recycle with ChangeNotifier {
  List<Murls> _recycle = [];

  List<Murls> get items {
    return _recycle;
  }

  Future<void> fetchAndSetUrls() async {
    const url = '$consturl/_/recycled-urls';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": 'application/json; charset=UTF-8',
          'Authorization': '${AuthService.instance.auth0AccessToken}',
        },
      );

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
          Expirydatetime: DateTime.now().toIso8601String(),
          boost: false,
          click: 0,
          Createddatetime: DateTime.now().toIso8601String(),
          UserURl: urlsData['shortened'],
        ));
      }

      _recycle = loadedUrls.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> Restored(String urlId) async {
    final url = '$consturl/_/recycled-urls/$urlId';
    final existingurlindex = _recycle.indexWhere((url) => url.Id == urlId);
    Murls? existingurl = _recycle[existingurlindex];
    _recycle.removeAt(existingurlindex);
    notifyListeners();

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${AuthService.instance.auth0AccessToken}',
      },
    );
    if (response.statusCode >= 400) {
      _recycle.insert(existingurlindex, existingurl);
      notifyListeners();
      throw HttpException('Could not restore product.');
    }
    existingurl = null;
  }

  Future<void> delete(String urlId) async {
    final url = '$consturl/_/recycled-urls/$urlId';
    final existingurlindex = _recycle.indexWhere((url) => url.Id == urlId);
    Murls? existingurl = _recycle[existingurlindex];
    _recycle.removeAt(existingurlindex);
    notifyListeners();

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${AuthService.instance.auth0AccessToken}',
      },
    );
    if (response.statusCode >= 400) {
      _recycle.insert(existingurlindex, existingurl);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingurl = null;
  }
}
