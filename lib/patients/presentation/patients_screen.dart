import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project_physician/patients/data/patients_repository.dart';
import 'package:thesis_project_physician/patients/presentation/patient_details.dart';
import 'package:thesis_project_physician/profile/model/userModel.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  List<UserModel> _filteredPatients = [];
  List<UserModel> _allPatients = [];
  bool _isSearchBarVisible = false;

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

    return Scaffold(
      appBar: AppBar(
        title: _isSearchBarVisible
            ? TextField(
                onChanged: _filterPatients,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Procurar paciente',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              )
            : Text("Lista de Pacientes",
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
        actions: [
          IconButton(
            icon: Icon(_isSearchBarVisible ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchBarVisible = !_isSearchBarVisible;
                if (!_isSearchBarVisible) {
                  _filterPatients('');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: patientsAsyncValue.when(
              data: (patients) {
                _allPatients = patients;
                _filteredPatients = _filteredPatients.isEmpty
                    ? _allPatients
                    : _filteredPatients;
                return ListView.builder(
                  itemCount: _filteredPatients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ListTile(
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
                                'Número de Utente: ${_filteredPatients[index].personNr}'),
                            if (_filteredPatients[index].birthDate != null)
                              Text(
                                  'Data de Nascimento: ${_filteredPatients[index].birthDate}')
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
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
      ),
    );
  }
}
