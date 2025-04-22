part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Signup State
final class SignupState extends AuthState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailed extends SignupState {}

// Login State
final class LoginState extends AuthState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}

final class Unauthenticated extends LoginState {}

/// user Login or Not before
class NewUser extends AuthState {}

class OldUser extends AuthState {}

// Rest Pssword state
final class resetPasswordStete extends AuthState {}

final class resetPasswordLoadingStete extends resetPasswordStete {}

final class resetPasswordSuccessStete extends resetPasswordStete {}

final class resetPasswordFailedStete extends resetPasswordStete {
  final String error;

  resetPasswordFailedStete(this.error);
}

/// Delete
class AuthDeleteLoadingState extends AuthState {}

class AuthDeleteSuccessededState extends AuthState {
  final String message;

  AuthDeleteSuccessededState(this.message);
}

class AuthDeleteFailingState extends AuthState {
  final String error;

  AuthDeleteFailingState(this.error);
}

///Upload
class UProPicUpdateLoadingState extends AuthState {}

class UProPicUpdateSuccessState extends AuthState {
  final String message;
  final String? downloadUrl;

  UProPicUpdateSuccessState(this.message, {this.downloadUrl});
}

class UProPicUpdateFailedState extends AuthState {
  final String error;

  UProPicUpdateFailedState(this.error);
}

////LogOut
class AuthLoading extends AuthState {}

class AuthLogoutSuccess extends AuthState {
  final String message;

  AuthLogoutSuccess(this.message);
}

class AuthLogoutFailed extends AuthState {
  final String error;

  AuthLogoutFailed(this.error);
}
