import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/edit_note.dart';
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
        title: const Text("Notes"),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: ListNote(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditNotePage(null, "add")),
          );
        },
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
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNotePage(note, "edit"),
              ),
            );
          },
          child: ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(NoteColors[note.noteColor]!['b']!),
                  maxRadius: 8,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(note.title),
              ],
            ),
            subtitle: (note.content.isNotEmpty)
                ? Text(
                    note.content,
                    textAlign: TextAlign.start,
                  )
                : const Text("None"),
            trailing: const Icon(
              Icons.chevron_right,
            ),
          ),
        );
      },
    );
  }
}
