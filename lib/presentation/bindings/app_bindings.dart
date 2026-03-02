import 'package:get/get.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../domain/usecases/note_usecases.dart';
import '../controllers/auth_controller.dart';
import '../controllers/note_controller.dart';
import '../../injection_container.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ));
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteController(
      getNotesUseCase: sl(),
      createNoteUseCase: sl(),
      updateNoteUseCase: sl(),
      deleteNoteUseCase: sl(),
    ));
  }
}
