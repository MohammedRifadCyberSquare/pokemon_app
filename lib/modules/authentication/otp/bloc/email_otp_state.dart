part of 'email_otp_bloc.dart';

@immutable
sealed class EmailOtpState {}

final class EmailOtpInitial extends EmailOtpState {}

final class VerificationSuccess extends EmailOtpState {}

final class VerificationFailed extends EmailOtpState {}
