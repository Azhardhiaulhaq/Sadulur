
class UmkmStoreState {
	final bool loading;
	final String error;

	UmkmStoreState(this.loading, this.error);

	factory UmkmStoreState.initial() => UmkmStoreState(false, '');

	UmkmStoreState copyWith({bool? loading, String? error}) =>
		UmkmStoreState(loading ?? this.loading, error ?? this.error);

	@override
	bool operator ==(other) =>
		identical(this, other) ||
		other is UmkmStoreState &&
			runtimeType == other.runtimeType &&
			loading == other.loading &&
			error == other.error;

	@override
	int get hashCode =>
		super.hashCode ^ runtimeType.hashCode ^ loading.hashCode ^ error.hashCode;

	@override
	String toString() => "UmkmStoreState { loading: $loading,  error: $error}";
}
	  