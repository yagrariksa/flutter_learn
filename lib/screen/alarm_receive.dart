// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class AlaramReceivePage extends StatefulWidget {
  const AlaramReceivePage(
    this.payload, {
    Key? key,
  }) : super(key: key);

  static const String routeName = "alarm_receive_page";

  final String? payload;

  @override
  State<AlaramReceivePage> createState() => _AlaramReceivePageState();
}

class _AlaramReceivePageState extends State<AlaramReceivePage> {
  String? _payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("Alaram Receive Page"),
              Text("Payload ${_payload ?? '_'}")
            ],
          ),
        ),
      ),
    );
  }
}
