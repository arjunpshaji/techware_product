import 'package:firebase_auth/firebase_auth.dart';

Exception mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return Exception('Email is already registered');
      case 'invalid-email':
        return Exception('Invalid email address');
      case 'operation-not-allowed':
        return Exception('Email/password registration is not enabled');
      case 'weak-password':
        return Exception('Password is too weak');
      default:
        return Exception('Registration failed: ${e.message}');
    }
  }