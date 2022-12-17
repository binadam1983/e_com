import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_com/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  StreamSubscription<User>? _userSubscription;

  AuthCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(authRepo.currentUser.isNotEmpty
            ? AppState.authenticated(authRepo.currentUser)
            : AppState.unauthenticated()) {
    _userSubscription = _authRepo.user.listen((user) {
      appUserChanged(user);
    });
  }

  void appUserChanged(User user) {
    emit(user.isNotEmpty
        ? AppState.authenticated(_authRepo.currentUser)
        : AppState.unauthenticated());
  }

  void logoutRequested() async {
    unawaited(_authRepo.logout());
  }

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
