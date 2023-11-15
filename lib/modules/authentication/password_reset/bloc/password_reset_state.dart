part of 'password_reset_bloc.dart';

@immutable
sealed class PasswordResetState {}

final class PasswordResetInitial extends PasswordResetState {}
final class PasswordChanged extends PasswordResetState {}
final class PasswordNotChanged extends PasswordResetState {}


