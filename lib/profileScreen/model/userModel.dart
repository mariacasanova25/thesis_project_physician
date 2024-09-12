import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  const UserModel(
      {required this.userId,
      required this.email,
      required this.personNr,
      required this.role,
      required this.username,
      this.birthDate});

  final String username;
  final String userId;
  final String email;
  final String role;
  final String? birthDate;
  final String personNr;

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    String? birthDate;
    if (data['birthDate'] != null) {
      // Assuming the date is stored as a Timestamp in Firestore
      birthDate = DateFormat('yyyy-MM-dd').format(data['birthDate'].toDate());
    }

    return UserModel(
        userId: snapshot.id,
        email: data['email'],
        personNr: data['personNr'],
        role: data['role'],
        birthDate: birthDate,
        username: data['username']);
  }
}
