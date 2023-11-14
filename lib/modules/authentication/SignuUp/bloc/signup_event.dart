part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class AddUserEvent extends SignupEvent{

  AddUserEvent({
    required this.userName,
    required this.email,
    required this.mobile,
    required this.password,

  });

  final String userName;
  final String email;
  final num mobile;
  final String password;
   
}
