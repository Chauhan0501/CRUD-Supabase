import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> createNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final SupabaseClient supabase;

  NoteRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<NoteModel>> getNotes() async {
    final response = await supabase
        .from('notes')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => NoteModel.fromJson(json)).toList();
  }

  @override
  Future<void> createNote(NoteModel note) async {
    await supabase.from('notes').insert(note.toJson());
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await supabase.from('notes').update(note.toJson()).eq('id', note.id!);
  }

  @override
  Future<void> deleteNote(String id) async {
    await supabase.from('notes').delete().eq('id', id);
  }
}
