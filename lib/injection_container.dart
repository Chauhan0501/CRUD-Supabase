import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/note_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/note_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/note_repository.dart';
import 'domain/usecases/auth_usecases.dart';
import 'domain/usecases/note_usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetNotesUseCase(sl()));
  sl.registerLazySingleton(() => CreateNoteUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => Supabase.instance.client);
}
