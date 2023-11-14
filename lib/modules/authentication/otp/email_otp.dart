import 'package:app/modules/authentication/Login/login_page.dart';
import 'package:app/modules/authentication/otp/bloc/email_otp_bloc.dart';
import 'package:app/modules/authentication/otp/bloc/resend-otp/resend_otp_bloc.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class EmailOtp extends StatelessWidget {
  final String userEmail;
  EmailOtp({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final _otpBloc = new EmailOtpBloc();
    final _resendOtpBloc = new ResendOtpBloc();

    TextEditingController _textOtpController = TextEditingController();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('OTP TextField'),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _otpBloc,
            child: Container(),
          ),
          BlocProvider(
            create: (context) => _resendOtpBloc,
            child: Container(),
          )
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<EmailOtpBloc, EmailOtpState>(
              listener: (context, state) {
                if (state is VerificationSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }
                if (state is VerificationFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Center(child: Text('Invalid Otp')),
                    ),
                  );
                }
              },
            ),
            BlocListener<ResendOtpBloc, ResendOtpState>(
              listener: (context, state) {
               
                if (state is ResendSuccess) {
                   print('22222222222222222224$state');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Center(child: Text('Otp Sent')),
                    ),
                  );
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    "Email Verification",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child: const Text(
                      "We have sent an Otp in ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      userEmail,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Pinput(
                    controller: _textOtpController,
                    length: 5,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.green),
                      ),
                    ),
                    onCompleted: (pin) => debugPrint(pin),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Text('Didn\'t receive an OTP?'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: BlocBuilder<ResendOtpBloc, ResendOtpState>(
                      builder: (context, state) {
                        return InkWell(
                         
                          onTap: () {
                             print('resend clik=cked');
                            context.read<ResendOtpBloc>().add(ResendOtp(
                                  mail: userEmail,
                                ));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Resend OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  hSpace(60),
                  SizedBox(
                    width: 100,
                    child: BlocBuilder<EmailOtpBloc, EmailOtpState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            context.read<EmailOtpBloc>().add(SubmitOpt(
                                  email: userEmail,
                                  otp: _textOtpController.text,
                                ));
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green.shade300,
                            // Padding around the button text
                            textStyle: TextStyle(
                              fontSize: 16, // Text size
                              fontWeight: FontWeight.bold, // Text font weight
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
