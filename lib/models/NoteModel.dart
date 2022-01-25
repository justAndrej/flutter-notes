class NoteModel {
  final String content;

  NoteModel({this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(content: json['content']);
  }
}
