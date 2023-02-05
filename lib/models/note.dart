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

    if (this.id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['content'] = content;
    data['noteColor'] = noteColor;

    return data;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      noteColor: json['noteColor'],
    );
  }
}
