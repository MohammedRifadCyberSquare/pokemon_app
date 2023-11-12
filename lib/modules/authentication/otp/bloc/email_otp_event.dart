part of 'email_otp_bloc.dart';

@immutable
abstract class EmailOtpEvent {}

class SubmitOpt extends EmailOtpEvent{
  final String email;
  final String otp;
  SubmitOpt({
   required this.email,
   required this.otp
  });
}
