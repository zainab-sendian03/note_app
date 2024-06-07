class note_model {
  int? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  int? userNote;

  note_model(
      {this.noteId,
      this.noteTitle,
      this.noteContent,
      this.noteImage,
      this.userNote});

  note_model.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteTitle = json['note_title'];
    noteContent = json['note_content'];
    noteImage = json['note_image'];
    userNote = json['user_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note_id'] = this.noteId;
    data['note_title'] = this.noteTitle;
    data['note_content'] = this.noteContent;
    data['note_image'] = this.noteImage;
    data['user_note'] = this.userNote;
    return data;
  }
}
