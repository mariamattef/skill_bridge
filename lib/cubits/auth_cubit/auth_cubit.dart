import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hal_app/screens/signin_screen.dart';
import 'package:hal_app/utilities/color_utilis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/buttom_nav_bar.dart';
import '../../services/email_service.dart';
import '../../widgets/custom_top_error_snack_bar.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  /// Logs in the user using Firebase Authentication.
  Future<void> login({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credentials.user != null) {
        if (!context.mounted) return;

        showErrorSnackBar(
          context,
          'You Logged In Successfully',
          ColorUtility.purble,
        );
        Navigator.pushReplacementNamed(context, BottomNavBar.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        showErrorSnackBar(
          context,
          'No user found for that email.',
          Colors.red.shade700,
        );
      } else if (e.code == 'wrong-password') {
        showErrorSnackBar(
          context,
          'Wrong password provided for that user.',
          Colors.red.shade700,
        );
      } else if (e.code == 'user-disabled') {
        showErrorSnackBar(context, 'User Disabled.', Colors.red.shade700);
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid Credential')));
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorSnackBar(context, 'Something went wrong', Colors.red.shade700);
    }
  }

  /// Creates a new user account with Firebase Authentication.
  Future<void> signUp({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      var credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credentials.user != null) {
        await sendWelcomeEmail(emailController.text);

        credentials.user!.updateDisplayName(nameController.text);
        if (!context.mounted) return;
        showErrorSnackBar(
          context,
          'Account created successfully',
          ColorUtility.purble,
        );

        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        showErrorSnackBar(
          context,
          'The password provided is too weak.',
          Colors.red.shade700,
        );
      } else if (e.code == 'email-already-in-use') {
        showErrorSnackBar(
          context,
          'The account already exists for that email.',
          Colors.red.shade700,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorSnackBar(context, 'Sign up Exception $e', Colors.red.shade700);
    }
  }

  /// Sends a password reset email to the given email address.
  Future<bool> resetPassword({
    required BuildContext context,
    required TextEditingController emailController,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      showErrorSnackBar(
        context,
        'Password reset email sent!',
        ColorUtility.purble,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorSnackBar(
          context,
          'No user found for that email.',
          Colors.red.shade700,
        );
      } else {
        showErrorSnackBar(
          context,
          'Failed to send password reset email',
          Colors.red.shade700,
        );
      }
      return false;
    } catch (e) {
      showErrorSnackBar(context, 'Something went wrong', Colors.red.shade700);
      return false;
    }
  }

  /// Confirms the password reset using the reset code and new password.
  Future<void> confirmPasswordReset({
    required BuildContext context,
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: oobCode,
        newPassword: newPassword,
      );

      if (!context.mounted) return;
      showErrorSnackBar(
        context,
        'Password updated successfully',
        ColorUtility.purble,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
      Navigator.pushReplacementNamed(context, SignInScreen.id);
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to reset password';
      if (e.code == 'expired-action-code') {
        message = 'The reset link has expired.';
      } else if (e.code == 'invalid-action-code') {
        message = 'Invalid or already used reset link.';
      }
      showErrorSnackBar(context, message, Colors.red.shade700);
    }
  }

  /// Updates the profile picture of the current user using Firebase Storage.
  Future<void> updateProfilePicture(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        emit(UProPicUpdateLoadingState());

        final storageRef = FirebaseStorage.instance.ref().child(
          'profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg',
        );
        await storageRef.putFile(File(image.path));

        final downloadUrl = await storageRef.getDownloadURL();

        await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
        showErrorSnackBar(
          context,
          'Profile picture updated successfully',
          ColorUtility.purble,
        );

        emit(
          UProPicUpdateSuccessState(
            'Profile picture updated',
            downloadUrl: downloadUrl,
          ),
        );
      } catch (e) {
        emit(UProPicUpdateFailedState('Failed to update profile picture: $e'));
        showErrorSnackBar(context, 'Error: $e', Colors.red.shade700);
      }
    } else {
      emit(UProPicUpdateFailedState('No image selected'));
    }
  }

  /// Returns the current logged-in user info (name, email, photo).
  Map<String, String?> getCurrentUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    return {
      'name': user?.displayName,
      'email': user?.email,
      'photoURL': user?.photoURL,
    };
  }

  /// Updates the display name of the current user.
  Future<void> updateUsername(String newName) async {
    emit(UpdateUsernameLoading());

    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(newName);
      await FirebaseAuth.instance.currentUser!.reload();
      final updatedName =
          FirebaseAuth.instance.currentUser!.displayName ?? newName;
      emit(UpdateUsernameSuccess(updatedName));
    } catch (e) {
      emit(UpdateUsernameFailed(e.toString()));
    }
  }

  /// Signs out the current user and clears shared preferences.
  Future<void> signOut(BuildContext context) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(AuthLogoutSuccess('Logged out'));

      if (context.mounted) {
        showErrorSnackBar(context, 'Logged Out', ColorUtility.purble);

        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } catch (e) {
      if (!context.mounted) return;
      showErrorSnackBar(context, 'Failed to log out : $e', Colors.red.shade700);

      emit(AuthLogoutFailed('Logout failed: $e'));
    }
  }
}
