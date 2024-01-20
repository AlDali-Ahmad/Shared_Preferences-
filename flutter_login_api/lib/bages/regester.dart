import 'dart:convert';
import 'package:flutter_login_api/bages/test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'الاسم'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'تأكيد كلمة المرور'),
            ),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              child: Text('تسجيل'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final Map<String, String> data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    final Uri url = Uri.parse('http://127.0.0.1:8000/api/register');

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
        print('تم التسجيل بنجاح');

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
