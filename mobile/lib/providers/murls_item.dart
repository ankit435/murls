import 'package:flutter/foundation.dart';

class Murls with ChangeNotifier {
  final String Alias;
  final String murlsUrl;
  final String UserURl;
  final String Createddatetime;
  final String Expirydatetime;
  final int click;
  final String Id;
  bool boost;
  Murls({
    required this.Alias,
    required this.murlsUrl,
    required this.UserURl,
    required this.Createddatetime,
    required this.Expirydatetime,
    required this.click,
    this.boost = false,
    required this.Id,
  });
  void toggleBoostStatus() {
    boost = !boost;
    notifyListeners();
  }
}
