part of 'resend_otp_bloc.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}
final class ResendSuccess extends ResendOtpState {}
