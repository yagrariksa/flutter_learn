import 'package:flutter/material.dart';
import 'package:flutter_learn/models/note.dart';
import 'package:flutter_learn/utils/font.dart';
import 'package:flutter_learn/utils/note_colors.dart';

const c1 = 0xFFFDFFFC,
    c2 = 0xFFFF595E,
    c3 = 0xFF374B4A,
    c4 = 0xFF00B1CC,
    c5 = 0xFFFFD65C,
    c6 = 0xFFB9CACA,
    c7 = 0x80374B4A;

class EditNotePage extends StatefulWidget {
  Note? note;
  String mode;
  EditNotePage(this.note, this.mode);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  String noteTitle = '';
  String noteContent = '';
  String noteColor = 'red';

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    noteTitle = (widget.mode == "add") ? '' : widget.note!.title;
    noteContent = (widget.mode == "add") ? '' : widget.note!.content;
    noteColor = (widget.mode == "add") ? 'red' : widget.note!.noteColor;

    _noteTitleController.text = noteTitle;
    _noteController.text = noteContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(NoteColors[noteColor]!['l']!),
      appBar: AppBar(
        backgroundColor: Color(NoteColors[noteColor]!['b']!),
        title: NoteTitleEntry(_noteTitleController),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.color_lens,
              color: Color(c1),
            ),
            tooltip: 'Color Palette',
          ),
        ],
      ),
      body: NoteEntry(_noteController),
    );
  }
}

class NoteTitleEntry extends StatelessWidget {
  final _noteTitleController;
  // const NoteTitleEntry({Key? key}) : super(key: key);
  NoteTitleEntry(this._noteTitleController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _noteTitleController,
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        counter: null,
        counterText: "",
        hintText: 'Title',
        hintStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          height: 1.5,
        ),
      ),
      maxLength: 31,
      maxLines: 1,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        height: 1.5,
        color: Color(c1),
      ),
      textCapitalization: TextCapitalization.words,
    );
  }
}

class NoteEntry extends StatelessWidget {
  final _noteController;
  // const NoteEntry({Key? key}) : super(key: key);
  NoteEntry(this._noteController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: TextField(
        controller: _noteController,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        decoration: null,
        style: title2,
      ),
    );
  }
}
