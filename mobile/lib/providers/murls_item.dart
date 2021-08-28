import 'package:flutter/foundation.dart';

class Murls with ChangeNotifier {
  // ignore: non_constant_identifier_names
  final String Alias;
  final String murlsUrl;
  // ignore: non_constant_identifier_names
  final String UserURl;
  // ignore: non_constant_identifier_names
  final String Createddatetime;
  // ignore: non_constant_identifier_names
  final String Expirydatetime;
  final int click;
  // ignore: non_constant_identifier_names
  final String Id;
  bool boost;
  Murls({
    // ignore: non_constant_identifier_names
    required this.Alias,
    required this.murlsUrl,
    // ignore: non_constant_identifier_names
    required this.UserURl,
    // ignore: non_constant_identifier_names
    required this.Createddatetime,
    // ignore: non_constant_identifier_names
    required this.Expirydatetime,
    required this.click,
    this.boost = false,
    // ignore: non_constant_identifier_names
    required this.Id,
  });
  void toggleBoostStatus() {
    boost = !boost;
    notifyListeners();
  }
}
