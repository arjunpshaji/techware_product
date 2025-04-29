import 'package:firebase_auth/firebase_auth.dart';
import 'package:techware_products/core/utils/firebase_error_mapper.dart';
import 'package:techware_products/core/utils/secure_storage_support.dart';
import 'package:techware_products/domain/enitities/user_entity.dart';
import 'package:techware_products/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  // Register
  @override
  Future<UserEntity> register({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Registration failed: No user data');
      }

      return UserEntity(uid: userCredential.user!.uid, email: userCredential.user!.email ?? '');
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // Login
  @override
  Future<UserEntity> login({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Login failed: No user data');
      }

      return UserEntity(uid: userCredential.user!.uid, email: userCredential.user!.email ?? '');
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthError(e);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Logout
    Future<void> logout() async {
    await _firebaseAuth.signOut();
    SecureStorageService.deletePin();
  }
}
