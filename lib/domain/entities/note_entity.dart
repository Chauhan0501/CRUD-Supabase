class NoteEntity {
  final String? id;
  final String title;
  final String content;
  final String? userId;
  final DateTime? createdAt;

  NoteEntity({
    this.id,
    required this.title,
    required this.content,
    this.userId,
    this.createdAt,
  });
}
