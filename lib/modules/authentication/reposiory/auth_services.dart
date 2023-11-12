import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../api.dart';

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

  
}

