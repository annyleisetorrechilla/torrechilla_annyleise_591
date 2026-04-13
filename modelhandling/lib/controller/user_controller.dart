
import 'package:modelhandling/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class UserController {
  final supabase = Supabase.instance.client;
  // Get all users
  Future<List<User>> getUsers() async {
    final data = await supabase.from('users').select();
    return data.map((item) => User.fromMap(item)).toList();
  }

  // Add user
  Future<void> addUser(User user) async {
    await supabase.from('users').insert(user.toMap());
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    await supabase.from('users').delete().eq('id', id);
  }
}