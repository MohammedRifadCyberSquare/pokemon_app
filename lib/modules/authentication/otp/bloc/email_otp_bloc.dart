 
import 'package:app/modules/authentication/reposiory/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'email_otp_event.dart';
part 'email_otp_state.dart';

class EmailOtpBloc extends Bloc<EmailOtpEvent, EmailOtpState> {
  EmailOtpBloc() : super(EmailOtpInitial()) {
    on<EmailOtpEvent>((event, emit) async{
      
      if(event is SubmitOpt){
         Map<String, dynamic> credentials = {
           
          'email': event.email,
          'otp': event.otp,
           
        };
        try {
          dynamic response = await AuthService().verifyOtp(credentials);
           
          if(response['statusCode'] == 200){
            
            print('succeess');
            emit(VerificationSuccess());
          }
          if(response['statusCode'] == 404){
            print('failed');
            emit(VerificationFailed());
            
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    });
    
  }
}
