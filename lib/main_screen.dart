import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learn/edit_note.dart';
import 'package:flutter_learn/models/note.dart';
import 'package:flutter_learn/models/note_database.dart';
import 'package:flutter_learn/utils/note_colors.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ListNotePage extends StatefulWidget {
  const ListNotePage({super.key});

  @override
  State<ListNotePage> createState() => _ListNotePageState();
}

class _ListNotePageState extends State<ListNotePage> {
  List<Map<String, dynamic>> _notesData = [];

  void afterNavigate() {
    setState(() {});
  }

  void navigate(BuildContext context, Note? note, String mode) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditNotePage(note, mode)),
    ).then((value) => {afterNavigate()});
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    try {
      NoteDatabase noteDB = NoteDatabase();
      List<Map<String, dynamic>> notes = await noteDB.all();
      print("m:getAllNotes: GET ${notes.length} DATA");
      return notes;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: FutureBuilder(
        future: getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _notesData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListNote(_notesData, afterNavigate),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(c3),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigate(context, null, "add");
        },
      ),
    );
  }
}

class ListNote extends StatelessWidget {
  final List<Map<String, dynamic>> noteData;
  final VoidCallback callbackAfterPop;
  ListNote(this.noteData, this.callbackAfterPop);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: noteData.length,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var noteMap = noteData.elementAt(index);
        var note = Note.fromJson(noteMap);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNotePage(note, "edit"),
              ),
            ).then((value) => {callbackAfterPop()});
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
