import 'dart:convert';

// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import '../../../api.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AuthService {
  
  Future<dynamic> registerUser(dynamic userData) async {
    dynamic response = await http.post(Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData));

    dynamic responseObj = json.decode(response.body);
    print('***************************');
    print(responseObj);

    return responseObj;
  }


   Future<dynamic> verifyOtp(dynamic credentials) async {
    dynamic response = await http.post(
      Uri.parse('$baseUrl/signup/verify-email'),
      headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials)
    );
     dynamic responseObj = json.decode(response.body);
    return responseObj;
  }

  Future<dynamic> userLogin(dynamic credentials) async {
    dynamic response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials)
    );
     dynamic responseObj = json.decode(response.body);
    return responseObj;
  }

   Future<dynamic> resendOtp(dynamic credentials) async {
    dynamic response = await http.post(
      Uri.parse('$baseUrl/signup/resend-otp'),
      headers: {'Content-Type': 'application/json'},
        body: json.encode(credentials)
    );
     dynamic responseObj = json.decode(response.body);
    return responseObj;
  }


    sendOtpToUser(String email, num otp) async {
    print('0000000000000000000000000000000000000000000000');
     String emailId = 'mohammedrifad17@gmail.com';
     String password = 'cdxciiuzbbrjidqz';
      final smtpServer = gmail(emailId, password);

       final message = Message()
    ..from = Address(emailId)
    ..recipients.add(email) // Recipient's email address
    ..subject = 'Verification code'
    ..text = '''Dear user,
Your code is $otp. Use it yo verify your email id.

  Yours,
  Pokedex Team
''';
     try {
    final sendReport = await send(message, smtpServer);
    print('email is sent');
    // print('Message sent: ${sendReport.sent}');
  } catch (error, stackTrace) {
      print('Error sending email: $error');
      print('Stack Trace: $stackTrace');
    }
  }

  
}

