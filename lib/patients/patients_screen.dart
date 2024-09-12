import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project_physician/patients/data/patients_repository.dart';
import 'package:thesis_project_physician/patients/patient_details.dart';
import 'package:thesis_project_physician/profileScreen/model/userModel.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  List<UserModel> _filteredPatients = [];
  List<UserModel> _allPatients = [];

  void _filterPatients(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPatients = _allPatients;
      });
    } else {
      setState(() {
        _filteredPatients = _allPatients.where((patient) {
          final queryLower = query.toLowerCase();
          final usernameMatches =
              patient.username.toLowerCase().contains(queryLower);
          final personNrMatches = patient.personNr.contains(query);

          bool birthDateMatches = false;
          if (patient.birthDate != null) {
            birthDateMatches = patient.birthDate!.toString().contains(query);
          }

          return usernameMatches || personNrMatches || birthDateMatches;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsyncValue = ref.watch(watchPatientsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterPatients,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Procurar paciente',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: patientsAsyncValue.when(
            data: (patients) {
              _allPatients = patients;
              _filteredPatients =
                  _filteredPatients.isEmpty ? _allPatients : _filteredPatients;
              return ListView.builder(
                itemCount: _filteredPatients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetails(
                              patientId: _filteredPatients[index].userId,
                              patientUsername:
                                  _filteredPatients[index].username,
                            ),
                          ));
                    },
                    title: Text(_filteredPatients[index].username),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Numero Utente: ${_filteredPatients[index].personNr}'),
                        if (_filteredPatients[index].birthDate != null)
                          Text(
                              'Data Nascimento: ${_filteredPatients[index].birthDate}')
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}
