import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thesis_project_physician/profile/model/userModel.dart';

part 'patients_repository.g.dart';

class PatientsRepository {
  const PatientsRepository({required this.firestore});

  final FirebaseFirestore firestore;

  Stream<List<UserModel>> watchPatients() {
    return firestore
        .collection('users')
        .where('role', isEqualTo: 'Paciente')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }
}

@riverpod
PatientsRepository patientsRepository(PatientsRepositoryRef ref) {
  return PatientsRepository(firestore: FirebaseFirestore.instance);
}

@riverpod
Stream<List<UserModel>> watchPatients(WatchPatientsRef ref) {
  return ref.watch(patientsRepositoryProvider).watchPatients();
}
