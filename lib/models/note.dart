class Note {
  int? id;
  String title;
  String content;
  String noteColor;

  Note({
    this.id = null,
    this.title = "Note",
    this.content = "Text",
    this.noteColor = "red",
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['title'] = this.title;
    data['content'] = this.content;
    data['noteColor'] = this.noteColor;

    return data;
  }
}
