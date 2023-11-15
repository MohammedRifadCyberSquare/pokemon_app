part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}
  class SubmitEmail extends ForgotPasswordEvent {
  final String email;
  SubmitEmail({
    required this.email
  });
}

