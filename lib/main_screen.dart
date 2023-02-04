import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/models/note.dart';
import 'package:flutter_learn/utils/note_colors.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

final mockNote = Iterable.generate(
  10,
  (index) => Note(
      id: index,
      title: "Title #${index + 1}",
      content: lorem(
        paragraphs: Random().nextInt(3),
        words: Random().nextInt(50),
      ),
      noteColor:
          NoteColors.keys.elementAt(Random().nextInt(NoteColors.length))),
);

class ListNotePage extends StatelessWidget {
  const ListNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: const Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListNote(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class ListNote extends StatelessWidget {
  const ListNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: mockNote.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var note = mockNote.elementAt(index);
        return ListTile(
          title: Text("${note.title}"),
          subtitle: (note.content.length > 0)
              ? Text(
                  "${note.content}",
                  textAlign: TextAlign.start,
                )
              : Text("None"),
          trailing: Icon(
            Icons.chevron_right,
          ),
        );
      },
    );
  }
}
