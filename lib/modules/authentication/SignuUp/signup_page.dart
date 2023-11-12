import 'package:app/modules/authentication/Login/login_page.dart';
import 'package:app/modules/authentication/SignuUp/bloc/signup_bloc.dart';
import 'package:app/modules/authentication/otp/email_otp.dart';
import 'package:app/shared/ui/widgets/heading.dart';
import 'package:app/shared/ui/widgets/primaryButton.dart';
import 'package:app/shared/ui/widgets/textformfield.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/shared/utils/sizes.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _signupBloc = new SignupBloc();
    
    TextEditingController _textNameController = TextEditingController();
    TextEditingController _textEmailController = TextEditingController();
    TextEditingController _textMobileController = TextEditingController();
    TextEditingController _textPasswordController = TextEditingController();
    TextEditingController _textConfirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: BlocProvider(
        create: (context) => _signupBloc,
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailOtp(
                    userEmail: state.email,
                  ),
                ),
              );
            }

            if (state is EmailExist) {
               
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Center(child: Text('Email Exists')),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              height: _deviceHeight,
              width: _deviceWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:AssetImage('assets/images/R.jpg')),
                // color: Colors.red,
              ),
              child: Center(
                child: Container(
                  height: _deviceHeight,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      hSpace(_deviceHeight * 0.11),
                      Heading(
                          text: 'SignUp',
                          size: TextSizes.headingSize,
                          weight: FontWeight.bold,
                          color: Colors.red),
                      hSpace(20),
                      TextFormField(
                          controller: _textNameController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                           
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                              Icons.verified_user_rounded,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                      hSpace(20),
                     TextFormField(
                     
                          controller: _textMobileController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          
                          decoration: InputDecoration(
                            labelText: 'Phone',
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
                       TextFormField(
                          controller: _textPasswordController,
                          style: TextStyle(
                            fontFamily: 'circular',
                            color: FormColors.fieldTextcolor,
                            fontSize: 18,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                      BlocBuilder<SignupBloc, SignupState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            label: 'Signup',
                            width: 100,
                            onPressed: () {
                              // Fluttertoast.showToast(
                              //   backgroundColor: Colors.red,
                              //   msg: "Email Taken",
                              //   toastLength: Toast.LENGTH_SHORT,
                              //   gravity: ToastGravity.CENTER,
                              // );

                              context.read<SignupBloc>().add(
                                    AddUserEvent(
                                        userName:  _textNameController.text,
                                        email: _textEmailController.text,
                                        mobile: num.parse(
                                            _textPasswordController.text),
                                        password: _textPasswordController.text),
                                  );
                              // context.read()<SignupBloc>().add(
                              //       AddUserEvent(
                              //           userName: 'Rifad',
                              //           email: 'test@gmail.com',
                              //           mobile: '9888',
                              //           password: 123),
                              //     );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginScreen()));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
