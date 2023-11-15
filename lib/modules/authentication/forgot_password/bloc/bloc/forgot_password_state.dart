part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class OtpSentSuccesfully extends ForgotPasswordState {
  final String email;
  final String otp;
  OtpSentSuccesfully({required this.email, required this.otp});
}
final class EmailNotFound extends ForgotPasswordState {
  
}


