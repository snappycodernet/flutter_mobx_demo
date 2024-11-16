import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppProviderState {
  bool isLoading = false;
  String? error;

  AppProviderState({
    this.isLoading = false,
    this.error
  });
}

class AppNotifier extends StateNotifier<AppProviderState> {
  AppNotifier() : super(AppProviderState());

  void setLoading(bool loading) {
    state = copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = copyWith(error: error);
  }

  AppProviderState copyWith({bool? isLoading, String? error}) {
    return AppProviderState(
        isLoading: isLoading ?? state.isLoading,
        error: error ?? state.error
    );
  }
}

final appProvider = StateNotifierProvider<AppNotifier, AppProviderState>((ref) {
  return AppNotifier();
});