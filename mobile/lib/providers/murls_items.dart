import 'package:flutter/material.dart';
import './murls_item.dart';

class murls_detail with ChangeNotifier {
  List<Murls> _items = [
    // Murls(
    //     Alias: 'ankit',
    //     murlsUrl: 'hshwjvww',
    //     click: 0,
    //     Id: DateTime.now().toString(),
    //     datetime: DateTime.now().toString()),
    // Murls(
    //     Alias: 'ankit',
    //     murlsUrl: 'hshwjvww',
    //     click: 0,
    //     Id: DateTime.now().toString(),
    //     datetime: DateTime.now().toString()),
  ];

  List<Murls> get items {
    return _items;
  }

  Murls findById(String id) {
    return _items.firstWhere((urls) => urls.Id == id);
  }

  void addUrls(Murls murls) {
    final newURls = Murls(
        Alias: murls.Alias,
        murlsUrl: murls.murlsUrl,
        datetime: murls.datetime,
        click: murls.click,
        boost: murls.boost,
        Id: murls.Id);

    _items.add(newURls);

    print(_items.length);
    notifyListeners();
  }

  void removeItem(String urlId) {
    final existingurlindex = _items.indexWhere((url) => url.Id == urlId);
    Murls? existingurl = _items[existingurlindex];
    _items.removeAt(existingurlindex);
    notifyListeners();
  }
}
