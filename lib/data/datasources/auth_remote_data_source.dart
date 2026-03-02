import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User?> login(String email, String password);
  Future<User?> register(String email, String password);
  Future<void> logout();
  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl(this.supabase);

  @override
  Future<User?> login(String email, String password) async {
    print('Attempting login for: $email');
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    print('Login successful for: ${response.user?.email}');
    return response.user;
  }

  @override
  Future<User?> register(String email, String password) async {
    print('Attempting registration for: $email');
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    print('Registration successful for: ${response.user?.email}');
    return response.user;
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
}
