import 'package:flutter/material.dart';
import 'package:flutter_login_api/bages/regester.dart';
import 'package:flutter_login_api/bages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Color.fromARGB(255, 65, 92, 225),
        ),
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext drawerContext) {
              return ListView(
                children: [
                  ListTile(
                    title: Text('Regester'),
                    onTap: () {
                      print('Regester');
                      Navigator.push(
                        drawerContext,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Login'),
                    onTap: () {
                      print('Login');
                      Navigator.push(
                        drawerContext,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
