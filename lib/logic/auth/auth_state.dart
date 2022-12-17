// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AppStatus { authenticated, unauthenticated }

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AppState extends AuthState {
  AppStatus appStatus;
  User? user;

  AppState._({required this.appStatus, this.user});

  AppState.authenticated(User user)
      : this._(appStatus: AppStatus.authenticated, user: user);
  AppState.unauthenticated() : this._(appStatus: AppStatus.unauthenticated);

  @override
  List<Object?> get props => [appStatus, user];
}
