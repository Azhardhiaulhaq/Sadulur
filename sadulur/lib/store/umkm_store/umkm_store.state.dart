import 'package:flutter/foundation.dart';
import 'package:sadulur/models/umkm_store.dart';

class UmkmStoreState {
  final bool loading;
  final String error;
  final List<UMKMStore> umkmStores;

  UmkmStoreState({
    required this.loading,
    required this.error,
    required this.umkmStores,
  });

  factory UmkmStoreState.initial() {
    return UmkmStoreState(
      loading: false,
      error: '',
      umkmStores: [],
    );
  }

  UmkmStoreState copyWith(
          {bool? loading,
          String? error,
          List<UMKMStore>? umkmStores,
          UMKMStore? storeDetail}) =>
      UmkmStoreState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        umkmStores: umkmStores ?? this.umkmStores,
      );

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is UmkmStoreState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          error == other.error &&
          listEquals(umkmStores, other.umkmStores);

  @override
  int get hashCode =>
      super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "UmkmStoreState { loading: $loading,  error: $error, List umkmStores: $umkmStores }";
}
