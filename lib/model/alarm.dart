import 'package:intl/intl.dart';

class Alarm {
  String? _name;
  List<int> _day;
  DateTime time;
  bool active = false;

  Alarm(this._day, this.time, this.active);

  toggleActive() {
    active = !active;
  }

  String tellTime() {
    return DateFormat("kk:mm").format(time);
  }

  String tellName() {
    return _name ?? "";
  }
}
