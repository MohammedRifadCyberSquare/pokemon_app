part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccess extends SignupState {
  final String email;
  SignupSuccess({required this.email});
}
final class EmailExist extends SignupState {}
