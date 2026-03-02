import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../injection_container.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  });

  var isLoading = false.obs;
  var user = Rxn<User>();
  var isLoginMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialSession();
  }

  void _checkInitialSession() {
    final currentUser = sl<AuthRepository>().getCurrentUser();
    if (currentUser != null) {
      user.value = currentUser;
      Future.delayed(const Duration(milliseconds: 100), () {
        if (Get.currentRoute == '/login' || Get.currentRoute == '/onboard') {
          Get.offAllNamed('/home');
        }
      });
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUseCase(LoginParams(email: email, password: password));
    print(result);
    result.fold(
      (failure) {
        print('Login Error: ${failure.message}');
        if (failure.message.contains('Invalid login credentials') || 
            failure.message.contains('User not found')) {
          Get.snackbar('Error', 'User not found. Switching to registration...');
          isLoginMode.value = false;
        } else {
          Get.snackbar('Error', failure.message);
        }
      },
      (u) {
        user.value = u;
        Get.offAllNamed('/home');
      },
    );
    isLoading.value = false;
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    final result = await registerUseCase(RegisterParams(email: email, password: password));
    print(result);
    result.fold(
      (failure) {
        print('Register Error: ${failure.message}');
        Get.snackbar('Error', failure.message);
      },
      (u) {
        user.value = u;
        Get.offAllNamed('/home');
      },
    );
    isLoading.value = false;
  }

  Future<void> logout() async {
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) {
        print('Logout Error: ${failure.message}');
        Get.snackbar('Error', failure.message);
      },
      (_) {
        user.value = null;
        Get.offAllNamed('/login');
      },
    );
  }
}
