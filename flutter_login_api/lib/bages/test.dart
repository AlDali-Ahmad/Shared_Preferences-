import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login_api/bages/gategore.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  final String token;

  const TestPage({Key? key, required this.token}) : super(key: key);

  Future<Map<String, dynamic>> getUserData() async {
    final Uri url = Uri.parse('http://127.0.0.1:8000/api/user');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userData = snapshot.data!;
                return Container(
                  child: Text("Welcome, ${userData}!"),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Gategore()),
              );
            },
            child: Text('Get Gategore'),
          ),
        ],
      ),
    );
  }
}
