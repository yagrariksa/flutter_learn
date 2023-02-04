import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/utils/font.dart';

class ListNotePage extends StatelessWidget {
  const ListNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              Text(
                "Notes",
                style: largeTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
