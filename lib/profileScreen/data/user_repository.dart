import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thesis_project_physician/profileScreen/model/userModel.dart';

part 'user_repository.g.dart';

class UserRepository {
  const UserRepository({required this.firestore});

  final FirebaseFirestore firestore;

  Stream<UserModel> watchAuthUser(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (snapshot) => UserModel.fromSnapshot(snapshot),
        );
  }

  Stream<UserModel> watchUser(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (snapshot) => UserModel.fromSnapshot(snapshot),
        );
  }
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(firestore: FirebaseFirestore.instance);
}

@riverpod
Stream<UserModel> watchAuthUser(WatchAuthUserRef ref) {
  final user = FirebaseAuth.instance.currentUser!;
  return ref.watch(userRepositoryProvider).watchAuthUser(user.uid);
}

@riverpod
Stream<UserModel> watchUser(WatchUserRef ref, String userId) {
  return ref.watch(userRepositoryProvider).watchUser(userId);
}
