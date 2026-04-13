import 'package:modelhandling/model/user_model.dart';
import 'package:modelhandling/model/userauth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class AuthController {
  final supabase = Supabase.instance.client;

  // Register new user
  Future<Map<String, dynamic>> register(
    String username,
    String password,
  ) async {
    try {
      // Check if username exists
      final existing = await supabase
          .from('usersauth')
          .select()
          .eq('username', username)
          .maybeSingle();

      if (existing != null) {
        return {'success': false, 'message': 'Username already exists'};
      }

      // Create new user
      final user = UserModel(username: username, password: password);
      await supabase.from('usersauth').insert(user.toMap());

      return {'success': true, 'message': 'Registration successful'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Login user
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final data = await supabase
          .from('usersauth')
          .select()
          .eq('username', username)
          .eq('password', password)
          .maybeSingle();

      if (data != null) {
        return {
          'success': true,
          'message': 'Login successful',
          'user': UserModel.fromMap(data),
        };
      } else {
        return {'success': false, 'message': 'Invalid username or password'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}