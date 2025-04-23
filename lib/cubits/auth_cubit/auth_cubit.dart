import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hal_app/screens/signin_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/buttom_nav_bar.dart';
import '../../services/email_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You Logged In Successfully')),
        );

        Navigator.pushReplacementNamed(context, BottomNavBar.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('User Disabled')));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid Credential')));
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign up Exception $e')));
    }
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required TextEditingController emailController,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );
      print("Sending reset to: ${emailController.text}");

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send password reset email')),
        );
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
      return false;
    }
  }

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );

        emit(
          UProPicUpdateSuccessState(
            'Profile picture updated',
            downloadUrl: downloadUrl,
          ),
        );
      } catch (e) {
        emit(UProPicUpdateFailedState('Failed to update profile picture: $e'));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else {
      emit(UProPicUpdateFailedState('No image selected'));
    }
  }

  Map<String, String?> getCurrentUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    return {
      'name': user?.displayName,
      'email': user?.email,
      'photoURL': user?.photoURL,
    };
  }

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

  Future<void> deleteUser(BuildContext context) async {
    emit(AuthDeleteLoadingState());

    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(AuthDeleteFailingState('No user logged'));
        return;
      }

      await user.delete();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(AuthDeleteSuccessededState(' deleting success'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('deleting success'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } on FirebaseAuthException catch (e) {
      emit(
        AuthDeleteFailingState(
          e.message ?? 'An error occurred while deleting the account.',
        ),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Failed deleting account'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      emit(AuthDeleteFailingState('Something went wrong'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(AuthLogoutSuccess('Logged out'));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged Out'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to log out : $e'),
          backgroundColor: Colors.red,
        ),
      );
      emit(AuthLogoutFailed('Logout failed: $e'));
    }
  }
}
