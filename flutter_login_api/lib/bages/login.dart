import 'dart:convert';
//import 'package:flutter_login_api/bages/as.dart';
import 'package:flutter_login_api/bages/test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
            ),
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final Map<String, String> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    final Uri url = Uri.parse('http://127.0.0.1:8000/api/login');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('تم تسجيل الدخول بنجاح');
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        print('Token: $token');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestPage(
              token: token,
            ),
          ),
        );
      } else {
        print('حدث خطأ: ${response.statusCode}');
      }
    } catch (error) {
      print('حدث خطأ: $error');
    }
  }
}
