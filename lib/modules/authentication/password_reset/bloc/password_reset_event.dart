part of 'password_reset_bloc.dart';

@immutable
abstract class PasswordResetEvent {}

class SubmitPasswordEvent extends PasswordResetEvent{
  final String email;
  final String newPassword;
   SubmitPasswordEvent({
    required this.email,
    required this.newPassword
  });
}
