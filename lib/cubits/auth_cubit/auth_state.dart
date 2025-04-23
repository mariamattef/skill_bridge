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



final class UProfilePicUpdateLoadingState extends AuthState {}

final class UProfilePicUpdateSuccessState extends AuthState {
  final String message;
  final String? downloadUrl;

  UProfilePicUpdateSuccessState(this.message, {this.downloadUrl});
}

final class UProfilePicUpdateFailedState extends AuthState {
  final String error;

  UProfilePicUpdateFailedState(this.error);
}

// Logout States
final class AuthLogoutLoadingState extends AuthState {}

final class AuthLogoutSuccessState extends AuthState {
  final String message;

  AuthLogoutSuccessState(this.message);
}

final class AuthLogoutFailedState extends AuthState {
  final String error;

  AuthLogoutFailedState(this.error);
}


final class Unauthenticated extends LoginState {}

// /// user Login or Not before
// class NewUser extends AuthState {}

// class OldUser extends AuthState {}

// Rest Pssword state
final class ResetPasswordStete extends AuthState {}

final class ResetPasswordLoadingStete extends ResetPasswordStete {}

final class ResetPasswordSuccessStete extends ResetPasswordStete {}

final class ResetPasswordFailedStete extends ResetPasswordStete {
  final String error;

  ResetPasswordFailedStete(this.error);
}


// Update user name 
class UpdateUsernameLoading extends AuthState {}

class UpdateUsernameSuccess extends AuthState {
  final String newName;

  UpdateUsernameSuccess(this.newName);
}

class UpdateUsernameFailed extends AuthState {
  final String error;

  UpdateUsernameFailed(this.error);
}


 ///////////////////////////////////////////////////

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

///Upload profile picture
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
