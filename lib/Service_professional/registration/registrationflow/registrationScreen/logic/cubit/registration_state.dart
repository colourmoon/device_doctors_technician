import 'package:flutter_bloc/flutter_bloc.dart';

// Define state
class RegistrationState {
  final bool isLoading;
  final bool registrationLoading;
  final String? registrationSuccess;
  final String? address;
  final bool isError;
  final String? registrationfailed;

  RegistrationState({
    required this.isLoading,
    required this.registrationLoading,
    this.address,
    this.registrationSuccess,
    required this.isError,
    this.registrationfailed,
  });

  RegistrationState copyWith({
    bool? isLoading,
    bool? registrationLoading,
    String? address,
    String? registrationSuccess,
    String? registrationfailed,
    bool? isError,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      registrationLoading: registrationLoading ?? this.registrationLoading,
      address: address ?? this.address,
      registrationSuccess: registrationSuccess ?? this.registrationSuccess,
      isError: isError ?? this.isError,
      registrationfailed: registrationfailed ?? this.registrationfailed,
    );
  }
}
