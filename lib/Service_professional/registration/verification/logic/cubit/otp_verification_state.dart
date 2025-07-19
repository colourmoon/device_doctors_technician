enum OtpStatus { Initial, Loading, Verified, Error }

abstract class OtpVerificationState {}

class OtpInitial extends OtpVerificationState {}

class OtpLoading extends OtpVerificationState {}

class OtpResend extends OtpVerificationState {}

class OtpVerified extends OtpVerificationState {}

class OtpError extends OtpVerificationState {
  final String errorMessage;

  OtpError(this.errorMessage);
}

class OtpResendTimer extends OtpVerificationState {
  final int secondsRemaining;

  OtpResendTimer(this.secondsRemaining);
}
