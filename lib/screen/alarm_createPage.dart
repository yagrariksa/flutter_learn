// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/alarm.dart';
import 'package:flutter_learn/model/alarm_sqflite_helper.dart';

class AlarmCreatePage extends StatefulWidget {
  const AlarmCreatePage({Key? key}) : super(key: key);

  static String routeName = "alarm_create";

  @override
  State<AlarmCreatePage> createState() => _AlarmCreatePageState();
}

class _AlarmCreatePageState extends State<AlarmCreatePage> {
  List<int> _day = [];
  late DateTime _dt;

  final AlarmSqfliteHelper alarmSqfliteHelper = AlarmSqfliteHelper();

  @override
  void initState() {
    // TODO: implement initState
    _dt = DateTime.now();
    super.initState();
  }

  void updateDay(int value) {
    setState(() {
      if (_day.contains(value)) {
        _day.removeWhere((element) => element == value);
      } else {
        _day.add(value);
        _day.sort();
      }
    });
  }

  void _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    print("pickedTime: $pickedTime");
    if (pickedTime != null) {
      DateTime now = DateTime.now();
      setState(() {
        _dt = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime!.hour,
          pickedTime!.minute,
        );
      });
    }
  }

  void backHandler() {
    Navigator.of(context).pop();
  }

  void saveNewAlarm() async {
    Alarm alarm = Alarm(_day, _dt);
    await alarmSqfliteHelper.insert(alarm);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Alarm"),
        actions: [
          TextButton(
            onPressed: saveNewAlarm,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: backHandler,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("Day : $_day"),
              dayCheckbox(0, "Sunday"),
              dayCheckbox(1, "Monday"),
              dayCheckbox(2, "Tuesday"),
              dayCheckbox(3, "Wednesday"),
              dayCheckbox(4, "Thursday"),
              dayCheckbox(5, "Friday"),
              dayCheckbox(6, "Saturday"),
              Divider(),
              Text("Time : ${_dt.hour}:${_dt.minute}"),
              ElevatedButton(
                onPressed: _showTimePicker,
                child: Text("Pick Time"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row dayCheckbox(int val, String day) {
    return Row(
      children: [
        Checkbox(
          value: _day.contains(val),
          onChanged: (bool? value) {
            updateDay(val);
          },
        ),
        TextButton(
            child: Text(
              day,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
              updateDay(val);
            }),
      ],
    );
  }
}
