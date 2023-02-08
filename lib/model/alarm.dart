import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Alarm {
  String _uid;
  String? _name;
  List<int> _day;
  DateTime time;
  bool active;

  static final String tableName = "alarms";

  Alarm._(this._uid, this._name, this._day, this.time, this.active);

  factory Alarm(
    List<int> _day,
    DateTime time, [
    bool active = false,
    String? _name,
    String? uid,
  ]) {
    return Alarm._(
      uid ?? Uuid().v4(),
      _name,
      _day,
      time,
      active,
    );
  }

  toggleActive() {
    active = !active;
  }

  String tellTime() {
    return DateFormat("kk:mm").format(time);
  }

  String tellName() {
    return _name ?? "";
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["uid"] = _uid;
    map["name"] = _name;
    map["day"] = _day.toString();
    map["time"] = tellTime();
    map["active"] = active;

    return map;
  }

  factory Alarm.fromJson(Map<String, dynamic> json) {
    String _strDay = json['day'].toString();
    _strDay = _strDay.substring(1, _strDay.length - 1);
    List<String> _listStrDay = _strDay.split(", ");
    List<int> _listDay = [];
    if (_listStrDay.length > 0) {
      _listStrDay.forEach(
        (element) {
          _listDay.add(int.parse(element));
        },
      );
    }

    String time = json['time'];
    var now = DateTime.now();
    DateTime datetime = DateTime(now.year, now.month, now.day,
        int.parse(time.split(":")[0]), int.parse(time.split(":")[1]));

    bool active = json['active'];

    String? name = json['name'];

    String uid = json['uid'];

    return Alarm(_listDay, datetime, active, name, uid);
  }
}
