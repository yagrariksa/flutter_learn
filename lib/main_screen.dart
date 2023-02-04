import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/models/note.dart';
import 'package:flutter_learn/utils/font.dart';
import 'package:flutter_learn/utils/note_colors.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

final mockNote = Iterable.generate(
  100,
  (index) => Note(
      id: index,
      title: "Title #${index + 1}",
      content: lorem(
        paragraphs: Random().nextInt(3),
        words: Random().nextInt(100),
      ),
      noteColor:
          NoteColors.keys.elementAt(Random().nextInt(NoteColors.length))),
);

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
