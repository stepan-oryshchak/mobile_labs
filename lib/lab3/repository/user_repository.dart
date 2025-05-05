import '../models/user_model.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<User?> loginUser(String email, String password);
  Future<User?> getUser();
  Future<void> updateUser(User user);
  Future<void> deleteUser();
}
