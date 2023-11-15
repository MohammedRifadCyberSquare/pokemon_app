import 'package:app/modules/authentication/reposiory/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is AddUserEvent) {
        print('********************************************');
        Map<String, dynamic> userData = {
          'name': event.userName,
          'email': event.email,
          'mobile': event.mobile,
          'password': event.password
        };

        try {
          dynamic response = await AuthService().registerUser(userData);
          print('Response: $response');
          if (response['statusCode'] == 201) {
            print('addeddd');
            print(
                "-------${response['email']} and ${response['generatedOtp'].runtimeType}");

            String emailContent = '''Dear user,
Your code is ${response['generatedOtp']}. Use it to verify your email id.

  Yours,
  Pokedex Team
''';
            await AuthService().sendOtpToUser(
                response['email'], 'Verification Code', emailContent);
            emit(SignupSuccess(email: event.email));
          }
          if (response['statusCode'] == 409) {
            print('email taken');
            emit(EmailExist());
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    });
  }

  Future<void> submitUser(dynamic userData) async {}
}
