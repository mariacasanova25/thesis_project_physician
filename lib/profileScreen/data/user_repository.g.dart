// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'169689c85de76a465e0d278ceedc030b578cb990';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$watchAuthUserHash() => r'f9e139b8d6f2a3c41a4de7c76750970cbd7dfeed';

/// See also [watchAuthUser].
@ProviderFor(watchAuthUser)
final watchAuthUserProvider = AutoDisposeStreamProvider<UserModel>.internal(
  watchAuthUser,
  name: r'watchAuthUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAuthUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAuthUserRef = AutoDisposeStreamProviderRef<UserModel>;
String _$watchUserHash() => r'c10fbd942fd8fafc1dca1c6d2a9625cb8453ace4';

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

/// See also [watchUser].
@ProviderFor(watchUser)
const watchUserProvider = WatchUserFamily();

/// See also [watchUser].
class WatchUserFamily extends Family<AsyncValue<UserModel>> {
  /// See also [watchUser].
  const WatchUserFamily();

  /// See also [watchUser].
  WatchUserProvider call(
    String userId,
  ) {
    return WatchUserProvider(
      userId,
    );
  }

  @override
  WatchUserProvider getProviderOverride(
    covariant WatchUserProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'watchUserProvider';
}

/// See also [watchUser].
class WatchUserProvider extends AutoDisposeStreamProvider<UserModel> {
  /// See also [watchUser].
  WatchUserProvider(
    String userId,
  ) : this._internal(
          (ref) => watchUser(
            ref as WatchUserRef,
            userId,
          ),
          from: watchUserProvider,
          name: r'watchUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchUserHash,
          dependencies: WatchUserFamily._dependencies,
          allTransitiveDependencies: WatchUserFamily._allTransitiveDependencies,
          userId: userId,
        );

  WatchUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<UserModel> Function(WatchUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchUserProvider._internal(
        (ref) => create(ref as WatchUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserModel> createElement() {
    return _WatchUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchUserProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchUserRef on AutoDisposeStreamProviderRef<UserModel> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _WatchUserProviderElement
    extends AutoDisposeStreamProviderElement<UserModel> with WatchUserRef {
  _WatchUserProviderElement(super.provider);

  @override
  String get userId => (origin as WatchUserProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
