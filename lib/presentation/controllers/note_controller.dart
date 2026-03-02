import 'package:get/get.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/note_usecases.dart';

class NoteController extends GetxController {
  final GetNotesUseCase getNotesUseCase;
  final CreateNoteUseCase createNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;

  NoteController({
    required this.getNotesUseCase,
    required this.createNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
  });

  var notes = <NoteEntity>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading.value = true;
    final result = await getNotesUseCase(NoParams());
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (list) => notes.value = list,
    );
    isLoading.value = false;
  }

  Future<void> addNote(String title, String content) async {
    final note = NoteEntity(title: title, content: content);
    final result = await createNoteUseCase(note);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) => fetchNotes(),
    );
  }

  Future<void> editNote(NoteEntity note) async {
    final result = await updateNoteUseCase(note);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) => fetchNotes(),
    );
  }

  Future<void> removeNote(String id) async {
    final result = await deleteNoteUseCase(id);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) => fetchNotes(),
    );
  }
}
