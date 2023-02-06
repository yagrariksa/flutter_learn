import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_learn/screen/alarm.dart';
import 'package:flutter_learn/screen/stopwatch.dart';
import 'package:flutter_learn/screen/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    AlarmPage(),
    StopwatchPage(),
    TimerPage(),
  ];

  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (newIndex) => updateIndex(newIndex),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.alarm,
              ),
              label: "Alarm",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.timer_outlined,
              ),
              label: "Stopwatch",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.av_timer_rounded,
              ),
              label: "Timer",
            ),
          ],
        ),
      ),
    );
  }
}
