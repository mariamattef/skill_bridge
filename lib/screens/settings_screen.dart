import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = FirebaseAuth.instance.currentUser;

          final name =
              (state is UpdateUsernameSuccess)
                  ? state.newName
                  : user?.displayName ?? 'User';

          final photoUrl =
              (state is UProPicUpdateSuccessState && state.downloadUrl != null)
                  ? state.downloadUrl
                  : user?.photoURL;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          photoUrl != null
                              ? NetworkImage(photoUrl)
                              : const AssetImage(
                                    'assets/images/default_user.png',
                                  )
                                  as ImageProvider,
                    ),
                    Positioned(
                      child: InkWell(
                        onTap:
                            () => context
                                .read<AuthCubit>()
                                .updateProfilePicture(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                subtitle: Text('Username: $name'),
                trailing: const Icon(Icons.edit),
                onTap: () => _showEditNameDialog(context, name),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Appearance'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () => _showLogoutConfirmation(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Edit Username'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'New Username'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().updateUsername(
                    controller.text.trim(),
                  );
                  Navigator.of(ctx).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Confirm'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      context.read<AuthCubit>().signOut(context);
    }
  }
}
