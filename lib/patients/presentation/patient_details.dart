import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thesis_project_physician/patients/data/patient_prescriptions_repository.dart';
import 'package:thesis_project_physician/patients/presentation/add_prescription_button.dart';
import 'package:thesis_project_physician/profile/data/user_repository.dart';

class PatientDetails extends ConsumerWidget {
  const PatientDetails(
      {super.key, required this.patientId, required this.patientUsername});
  final String patientId;
  final String patientUsername;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientPrescriptionsAsync =
        ref.watch(watchPatientPrescriptionsProvider(patientId));
    return Scaffold(
      appBar: AppBar(
        title: Text(patientUsername),
      ),
      body: patientPrescriptionsAsync.when(
          data: (prescriptions) {
            if (prescriptions.isEmpty) {
              return const Center(child: Text('Não tem prescrições.'));
            }
            return ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final physicianId = prescriptions[index].physicianId;
                final physicianAsync =
                    ref.watch(watchUserProvider(physicianId));
                return Card(
                  margin: const EdgeInsets.all(6),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ListTile(
                    title: Text(prescriptions[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Dosagem: ${prescriptions[index].dosage} comprimido'),
                        Text('Frequência: ${prescriptions[index].frequency}h'),
                        Text(
                            'Prescrito em: ${DateFormat('yyyy-MM-dd').format(prescriptions[index].startDate)}'),
                        Text(
                            'Duração: ${prescriptions[index].duration} dia(s)'),
                        Text('Motivo: ${prescriptions[index].motive}'),
                        physicianAsync.when(
                          data: (physician) =>
                              Text('Prescrito por: Dr. ${physician.username}'),
                          loading: () =>
                              const Text('Prescrito por: Carregando...'),
                          error: (error, stackTrace) =>
                              const Text('Prescrito por: Erro'),
                        ),
                      ],
                    ),
                    trailing: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          value: prescriptions[index].getGeneralAdherence(),
                        ),
                        Text(
                          '${(prescriptions[index].getGeneralAdherence() * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
      floatingActionButton: AddPrescriptionButton(
        patientId: patientId,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
