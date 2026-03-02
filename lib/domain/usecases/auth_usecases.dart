import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<User?, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class RegisterUseCase implements UseCase<User?, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String email;
  final String password;
  RegisterParams({required this.email, required this.password});
}
