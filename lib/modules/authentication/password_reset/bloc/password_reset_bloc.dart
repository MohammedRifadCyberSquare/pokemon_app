import 'package:app/modules/authentication/reposiory/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc() : super(PasswordResetInitial()) {
    on<PasswordResetEvent>((event, emit) async {
      
      if(event is SubmitPasswordEvent){
         Map<String, dynamic> credentials = {
          'email': event.email,
          'password': event.newPassword
        };

        try {
          dynamic response = await AuthService().resetUserPassword(credentials);
          if(response['statusCode'] == 201){
            emit(PasswordChanged());
          }

        }

        catch(e){}
      }
    });
  }
}
