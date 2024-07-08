import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  const UserModel(
      {required this.userId,
      required this.email,
      required this.personNr,
      required this.role,
      required this.username,
      this.bornDate});

  final String username;
  final String userId;
  final String email;
  final String role;
  final String? bornDate;
  final String personNr;

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    String? bornDate;
    if (data['bornDate'] != null) {
      // Assuming the date is stored as a Timestamp in Firestore
      bornDate = DateFormat('yyyy-MM-dd').format(data['bornDate'].toDate());
    }

    return UserModel(
        userId: snapshot.id,
        email: data['email'],
        personNr: data['personNr'],
        role: data['role'],
        bornDate: bornDate,
        username: data['username']);
  }
}
