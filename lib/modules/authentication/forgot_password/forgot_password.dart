import 'package:app/modules/authentication/forgot_password/bloc/bloc/forgot_password_bloc.dart';
import 'package:app/modules/authentication/otp/email_otp.dart';
import 'package:app/shared/ui/widgets/heading.dart';
import 'package:app/shared/ui/widgets/primaryButton.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
    ForgotPasswordScreen({super.key});

  final _bloc = new ForgotPasswordBloc();
  
  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    TextEditingController _textEmailController = TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is OtpSentSuccesfully) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content:
                      Center(child: Text('Otp has bee sent to your email')),
                ),
                
              );
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailOtp(
                    userEmail: state.email,
                    isSignup: false,
                    otp: state.otp,
                  ),
                ),
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomePage(),
              //   ),
              // );
            }

            if(state is EmailNotFound){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content:
                      Center(child: Text('Email not found')),
                ),
              );
            }

            // if (state is EmailNotVerified) {
            //   print('here');
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => EmailOtp(
            //         userEmail: state.email,
            //       ),
            //     ),
            //   );
            // }

            // if (state is LoginFailed) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     backgroundColor: Colors.red,
              //     content:
              //         Center(child: Text('Username or password incorrect')),
              //   ),
              // );
            // }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: _deviceHeight,
                width: _deviceWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/R.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        hSpace(_deviceHeight * 0.2),
                        Heading(
                            text: 'Enter Your Email',
                            size: TextSizes.subHeading,
                            weight: FontWeight.bold,
                            color: Colors.white),
                        hSpace(20),
                        TextFormField(
                          controller: _textEmailController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'circular',
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.4)),

                            filled: true,
                            fillColor: FormColors.fieldBackgroundColor
                                .withOpacity(0.25),
                            //enabled
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor, width: 2),
                              borderRadius:
                                  BorderRadius.circular(fieldBorderRadius),
                            ),

                            contentPadding: fieldPadding,

                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                        hSpace(20),
                         
                         
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) {
                            return  PrimaryButton(
                              label: 'Submit',
                              width: 100,
                              onPressed: () {
                                context.read<ForgotPasswordBloc>().add(
                                      SubmitEmail(
                                          email: _textEmailController.text,
                                        ),
                                    );
                              },
                            );
                          },
                        ),
                         
                         
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}