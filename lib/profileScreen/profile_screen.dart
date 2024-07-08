import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project_physician/profileScreen/data/user_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(watchAuthUserProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        body: userAsync.when(
          data: (user) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.person_2, size: 64),
                  const SizedBox(height: 8),
                  Text(
                    user.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(user.role),
                  const SizedBox(height: 8),
                  Text('Número de Utente: ${user.personNr}'),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    label: const Text('Terminar Sessão'),
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) => const SizedBox(
            width: 10,
          ),
          loading: () => const CircularProgressIndicator(),
        ));
  }
}
