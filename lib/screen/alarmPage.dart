import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/alarm.dart';
import 'package:flutter_learn/model/alarm_sqflite_helper.dart';
import 'package:flutter_learn/screen/alarm_createPage.dart';

final mockAlarm = Iterable.generate(
  100,
  (index) {
    var day = [0, 1, 2, 3, 4, 5, 6, 7];
    var rand = Random();
    var hour = rand.nextInt(13) + 10;
    var minute = rand.nextInt(59);
    var now = DateTime.now();
    DateTime datetime = DateTime(now.year, now.month, now.day, hour, minute);
    return Alarm(day, datetime, rand.nextBool());
  },
);

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _alarms = [];
  late AnimationController controller;

  void createAlarm() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlarmCreatePage(),
        ));
  }

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = mockAlarm.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: createAlarm,
      ),
      body: FutureBuilder(
        future: AlarmSqfliteHelper.loadAll(),
        builder: (context, snapshot) {
          return _screen(snapshot);
        },
      ),
    );
  }

  Widget _screen(AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
    if (snapshot.hasData) {
      print(snapshot.data);
      _alarms = snapshot.data!;
      if (snapshot.data != null && _alarms.length > 0) {
        return SafeArea(
            child: Center(
          child: AlarmList(_alarms),
        ));
      } else {
        return SafeArea(
            child: Center(
          child: TextButton(
            onPressed: createAlarm,
            child: const Text("Add Data!"),
          ),
        ));
      }
    } else if (snapshot.hasData) {
      return SafeArea(
          child: Center(
        child: Column(children: [
          const Text("Error"),
          TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("Try Again"))
        ]),
      ));
    } else {
      return Center(
        child: CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: "Loading",
        ),
      );
    }
  }
}

class AlarmList extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  const AlarmList(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var _alarm = list.elementAt(index);
        var alarm = Alarm.fromJson(_alarm);
        return Card(
          child: ListTile(
            title: Text(
              alarm.tellTime(),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            // subtitle: (alarm.tellName == "") ? null : Text(alarm.tellName()),
            trailing: IconButton(
              onPressed: () {},
              icon: alarm.active
                  ? const Icon(
                      Icons.toggle_on,
                      color: Colors.green,
                      size: 32,
                    )
                  : const Icon(
                      Icons.toggle_off_outlined,
                      size: 32,
                    ),
            ),
          ),
        );
      },
    );
  }
}
