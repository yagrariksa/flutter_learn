import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn/model/alarm.dart';

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

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    var data = mockAlarm.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: SafeArea(
          child: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text("Send Notif!"),
        ),
      )),
    );
  }
}

class AlarmList extends StatelessWidget {
  final List<Alarm> list;
  const AlarmList(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var alarm = list.elementAt(index);
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
