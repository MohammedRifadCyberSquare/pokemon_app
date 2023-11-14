import 'package:app/modules/authentication/SignuUp/bloc/signup_bloc.dart';
import 'package:app/modules/authentication/reposiory/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is UserLogin) {
        Map<String, dynamic> credentials = {
          'email': event.email,
          'password': event.password
        };
print(credentials);
        try {
          dynamic response = await AuthService().userLogin(credentials);
          print('Response: $response');
          if(response['statusCode'] == 201){
            
            var prefs = await SharedPreferences.getInstance();
            prefs.setString('userName', response['name']);
            prefs.setString('token', response['token']);


            print(response['statusCode']);
            emit(LoginSuccess());
          }
          if(response['statusCode'] == 502){
            print('email taken ${response['email']}');
            emit(EmailNotVerified(email: response['email']));
          }
           if(response['statusCode'] == 404){
            print('email taken');
            emit(LoginFailed());
            
          }
        } catch (e) {
          print('Error: $e');
        }
      }
      });
  }
}
