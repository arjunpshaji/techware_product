import 'package:firebase_auth/firebase_auth.dart';
import 'package:techware_products/data/repositories/auth_repository_impl.dart';
import 'package:techware_products/domain/enitities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepositoryImpl _authRepository;

  @override
  FutureOr<UserEntity?> build() {
    _authRepository = AuthRepositoryImpl(FirebaseAuth.instance);
    return null;
  }
  /// Authentication state notifier.
  ///
  /// Manages the current authentication state of the user.
  Future<void> register({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      final user = await _authRepository.register(email: email, password: password);
      state = AsyncData(user);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Login the user with the given email and password.
  ///
  /// Throws an exception if the login fails.
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      final user = await _authRepository.login(email: email, password: password);
      state = AsyncData(user);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Logout the current user.
  ///
  /// Throws an exception if the logout fails.
  Future<void> logout() async {
    state = const AsyncLoading();

    try {
      await _authRepository.logout();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}