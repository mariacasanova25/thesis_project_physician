// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescriptions_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientPrescriptionsRepositoryHash() =>
    r'd31f57a70ad4dd039dd78e68e371798f3919ec1f';

/// See also [patientPrescriptionsRepository].
@ProviderFor(patientPrescriptionsRepository)
final patientPrescriptionsRepositoryProvider =
    AutoDisposeProvider<PatientPrescriptionsRepository>.internal(
  patientPrescriptionsRepository,
  name: r'patientPrescriptionsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientPrescriptionsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientPrescriptionsRepositoryRef
    = AutoDisposeProviderRef<PatientPrescriptionsRepository>;
String _$watchPatientPrescriptionsHash() =>
    r'a23b0766fda7a07cfa4255c493ff3411d571079f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [watchPatientPrescriptions].
@ProviderFor(watchPatientPrescriptions)
const watchPatientPrescriptionsProvider = WatchPatientPrescriptionsFamily();

/// See also [watchPatientPrescriptions].
class WatchPatientPrescriptionsFamily
    extends Family<AsyncValue<List<Prescription>>> {
  /// See also [watchPatientPrescriptions].
  const WatchPatientPrescriptionsFamily();

  /// See also [watchPatientPrescriptions].
  WatchPatientPrescriptionsProvider call(
    String patientId,
  ) {
    return WatchPatientPrescriptionsProvider(
      patientId,
    );
  }

  @override
  WatchPatientPrescriptionsProvider getProviderOverride(
    covariant WatchPatientPrescriptionsProvider provider,
  ) {
    return call(
      provider.patientId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchPatientPrescriptionsProvider';
}

/// See also [watchPatientPrescriptions].
class WatchPatientPrescriptionsProvider
    extends AutoDisposeStreamProvider<List<Prescription>> {
  /// See also [watchPatientPrescriptions].
  WatchPatientPrescriptionsProvider(
    String patientId,
  ) : this._internal(
          (ref) => watchPatientPrescriptions(
            ref as WatchPatientPrescriptionsRef,
            patientId,
          ),
          from: watchPatientPrescriptionsProvider,
          name: r'watchPatientPrescriptionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchPatientPrescriptionsHash,
          dependencies: WatchPatientPrescriptionsFamily._dependencies,
          allTransitiveDependencies:
              WatchPatientPrescriptionsFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  WatchPatientPrescriptionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
  }) : super.internal();

  final String patientId;

  @override
  Override overrideWith(
    Stream<List<Prescription>> Function(WatchPatientPrescriptionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchPatientPrescriptionsProvider._internal(
        (ref) => create(ref as WatchPatientPrescriptionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Prescription>> createElement() {
    return _WatchPatientPrescriptionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchPatientPrescriptionsProvider &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchPatientPrescriptionsRef
    on AutoDisposeStreamProviderRef<List<Prescription>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _WatchPatientPrescriptionsProviderElement
    extends AutoDisposeStreamProviderElement<List<Prescription>>
    with WatchPatientPrescriptionsRef {
  _WatchPatientPrescriptionsProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as WatchPatientPrescriptionsProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
