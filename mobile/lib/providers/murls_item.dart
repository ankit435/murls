import 'package:flutter/foundation.dart';

class Murls with ChangeNotifier {
  final String Alias;
  final String murlsUrl;
  final String datetime;
  final int click;
  final String Id;
  bool boost;
  Murls({
    required this.Alias,
    required this.murlsUrl,
    required this.datetime,
    required this.click,
    this.boost = false,
    required this.Id,
    nulldateTime,
    dateTime,
    murlsurl,
  });
  void toggleBoostStatus() {
    boost = !boost;
    notifyListeners();
  }
}
