import 'package:flutter/material.dart';
import 'package:thesis_project_physician/patients/presentation/add_prescription_screen.dart';

class AddPrescriptionButton extends StatelessWidget {
  const AddPrescriptionButton({super.key, required this.patientId});
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPrescriptionScreen(patiendId: patientId),
          ),
        );
      },
      label: const Text("Prescrição"),
      icon: const Icon(Icons.add),
    );
  }
}
