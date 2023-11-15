import 'package:app/modules/authentication/reposiory/auth_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:math';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      if (event is SubmitEmail) {
        try {
          dynamic response =
              await AuthService().sendOtpForPasswordReset(event.email);

          print(response);
          if (response['statusCode'] == 201) {
            int min = 10000;
            int max = 99999;
            Random random = Random();
            num otp = min + random.nextInt(max - min + 1);
            print(otp);
            print('objectttttttttttttt');
             String emailContent = '''Dear user,
Your code is $otp. Use it to reset your password.

  Yours,
  Pokedex Team
''';
            
            await AuthService().sendOtpToUser(
                event.email, 'Verification Code For Password Reset', emailContent);
           
            emit(OtpSentSuccesfully(email: event.email, otp: otp.toString()));
          }

          if (response['statusCode'] == 404) {
            emit(EmailNotFound());
          }
        } catch (e) {}
      }
    });
  }
}
