import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project_physician/profile/data/user_repository.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String initUsername = '';
  String initEmail = '';
  String initRole = 'patient';
  String initPersonalNr = '';

  Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();
      await user.delete();
      if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print('Error during account deletion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userAsync = ref.watch(watchAuthUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userAsync.when(
          data: (user) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          child: Icon(Icons.account_circle, size: 88),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('Nome', style: textTheme.headlineSmall),
                  Text(user.username, style: textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  Text('Função', style: textTheme.headlineSmall),
                  Text(user.role, style: textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  Text('Cédula Profissional', style: textTheme.headlineSmall),
                  Text(user.personNr, style: textTheme.headlineLarge),
                  const SizedBox(height: 32),
                  Center(
                    child: OutlinedButton(
                        onPressed: deleteAccount,
                        child: Text("Apagar conta",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error))),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) => Center(
            child:
                Text('Erro ao carregar perfil', style: textTheme.headlineLarge),
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
