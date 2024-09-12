import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thesis_project_physician/patients/model/prescription.dart';

part 'patient_prescriptions_repository.g.dart';

class PatientPrescriptionsRepository {
  const PatientPrescriptionsRepository({required this.firestore});

  final FirebaseFirestore firestore;

  Stream<List<Prescription>> watchPatientPrescriptions(String patientId) {
    return firestore
        .collection('users')
        .doc(patientId)
        .collection('prescriptions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Prescription.fromSnapshot(doc))
            .toList());
  }
}

@riverpod
PatientPrescriptionsRepository patientPrescriptionsRepository(
    PatientPrescriptionsRepositoryRef ref) {
  return PatientPrescriptionsRepository(firestore: FirebaseFirestore.instance);
}

@riverpod
Stream<List<Prescription>> watchPatientPrescriptions(
    WatchPatientPrescriptionsRef ref, String patientId) {
  return ref
      .watch(patientPrescriptionsRepositoryProvider)
      .watchPatientPrescriptions(patientId);
}
