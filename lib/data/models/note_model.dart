import '../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    super.id,
    required super.title,
    required super.content,
    super.userId,
    super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      userId: json['user_id'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      if (userId != null) 'user_id': userId,
    };
  }

  factory NoteModel.fromEntity(NoteEntity note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      userId: note.userId,
      createdAt: note.createdAt,
    );
  }
}
