part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}
final class EmailNotVerified extends LoginState {
  final String email;
  EmailNotVerified({ required this.email});
}


final class LoginFailed extends LoginState {}
