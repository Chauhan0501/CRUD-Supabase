import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_remote_data_source.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    try {
      final notes = await remoteDataSource.getNotes();
      return Right(notes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createNote(NoteEntity note) async {
    try {
      await remoteDataSource.createNote(NoteModel.fromEntity(note));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    try {
      await remoteDataSource.updateNote(NoteModel.fromEntity(note));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String id) async {
    try {
      await remoteDataSource.deleteNote(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
