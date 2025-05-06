import 'dart:convert';
import 'package:mobile_first_lab/lab3/models/user_model.dart';
import 'package:mobile_first_lab/lab3/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  static const String userKey = 'user_data';

  @override
  Future<void> registerUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    if (jsonString == null) return null;

    final user = User.fromJson(jsonDecode(jsonString));
    return (user.email == email && user.password == password) ? user : null;
  }

  @override
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    return jsonString == null ? null : User.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> updateUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userKey);
  }
}
