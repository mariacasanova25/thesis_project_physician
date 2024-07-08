// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientsRepositoryHash() =>
    r'ad322b6c3c03c87c49075f589630819e88df5218';

/// See also [patientsRepository].
@ProviderFor(patientsRepository)
final patientsRepositoryProvider =
    AutoDisposeProvider<PatientsRepository>.internal(
  patientsRepository,
  name: r'patientsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientsRepositoryRef = AutoDisposeProviderRef<PatientsRepository>;
String _$watchPatientsHash() => r'36f7e4ad0e8065a6a85d9ed555d73abd20db6c64';

/// See also [watchPatients].
@ProviderFor(watchPatients)
final watchPatientsProvider =
    AutoDisposeStreamProvider<List<UserModel>>.internal(
  watchPatients,
  name: r'watchPatientsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchPatientsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchPatientsRef = AutoDisposeStreamProviderRef<List<UserModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
