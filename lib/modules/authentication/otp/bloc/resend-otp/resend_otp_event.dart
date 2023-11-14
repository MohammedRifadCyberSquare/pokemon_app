part of 'resend_otp_bloc.dart';

@immutable
abstract class ResendOtpEvent {}
 
class ResendOtp extends ResendOtpEvent{
  final String mail;
  
  ResendOtp({
  
   required this.mail
  });
}
