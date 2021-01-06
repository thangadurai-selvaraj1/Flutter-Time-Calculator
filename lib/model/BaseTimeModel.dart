import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class BaseTimeModel {
  var time;
  var location;
  var flag;
  var endPoint;
  var isDayTime;

  BaseTimeModel({this.location, this.flag, this.endPoint});

  Future<void> getTime() async {
    try {
      Response response =
          await get("http://worldtimeapi.org/api/timezone/$endPoint");

      Map data = jsonDecode(response.body);
      var datetime = data['datetime'];
      var offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime.toString());
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Unable to fetch';
    }
  }
}
