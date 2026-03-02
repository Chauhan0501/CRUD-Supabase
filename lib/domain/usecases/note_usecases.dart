import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase implements UseCase<List<NoteEntity>, NoParams> {
  final NoteRepository repository;
  GetNotesUseCase(this.repository);

  @override
  Future<Either<Failure, List<NoteEntity>>> call(NoParams params) async {
    return await repository.getNotes();
  }
}

class CreateNoteUseCase implements UseCase<void, NoteEntity> {
  final NoteRepository repository;
  CreateNoteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoteEntity params) async {
    return await repository.createNote(params);
  }
}

class UpdateNoteUseCase implements UseCase<void, NoteEntity> {
  final NoteRepository repository;
  UpdateNoteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoteEntity params) async {
    return await repository.updateNote(params);
  }
}

class DeleteNoteUseCase implements UseCase<void, String> {
  final NoteRepository repository;
  DeleteNoteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteNote(params);
  }
}
