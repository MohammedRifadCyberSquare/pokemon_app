import 'package:app/modules/authentication/Login/bloc/login_bloc.dart';
import 'package:app/modules/authentication/Login/login_page.dart';
import 'package:app/modules/authentication/SignuUp/signup_page.dart';
import 'package:app/modules/authentication/forgot_password/forgot_password.dart';
import 'package:app/modules/authentication/otp/email_otp.dart';
import 'package:app/modules/authentication/password_reset/bloc/password_reset_bloc.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/shared/ui/widgets/heading.dart';
import 'package:app/shared/ui/widgets/primaryButton.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetScreen extends StatelessWidget {
    PasswordResetScreen({required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
 final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    TextEditingController _textPasswordController = TextEditingController();
    TextEditingController _textConfirmPasswordController = TextEditingController();
    final _resetBloc = new PasswordResetBloc();

    return Scaffold(
      body: BlocProvider(
        create: (context) => _resetBloc,
        child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
          listener: (context, state) {
             
            if (state is PasswordChanged) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content:
                      Center(child: Text('Password reset succesful')),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }

           
            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content:
                      Center(child: Text('Username or password incorrect')),
                ),
              );
            }
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
                            text: 'Reset Password',
                            size: 25,
                            weight: FontWeight.bold,
                            color: Colors.white),
                        hSpace(20),
                        TextFormField(
                          controller: _textPasswordController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'New Password',
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
                              Icons.lock,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                        hSpace(20),
                        TextFormField(
                          controller: _textConfirmPasswordController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
                              Icons.lock,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                        hSpace(20),
                        BlocBuilder<PasswordResetBloc, PasswordResetState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              label: 'Reset',
                              width: 100,
                              onPressed: () {
                                context.read<PasswordResetBloc>().add(
                                      SubmitPasswordEvent(
                                          email:  email,
                                          newPassword:
                                              _textPasswordController.text),
                                    );
                              },
                            );
                          },
                        ),
                         

                         
                        // hSpace(20),
                        // MyTextButton(
                        //   label: 'SignUp!',
                        //   width: 100,
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => SignUpPage(),
                        //         ));
                        //   },
                        // ),
                        // hSpace(10),
                        // MyTextButton(
                        //   label: 'forgot password?',
                        //   width: 200,
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => ForgetPassword(),
                        //         ));
                        //   },
                        // )
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