import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Gategore extends StatefulWidget {
  @override
  _GategoreState createState() => _GategoreState();
}

class _GategoreState extends State<Gategore> {
  Map<String, dynamic>? gategoreData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await getDataFromSharedPreferences();

      if (data != null) {
        setState(() {
          gategoreData = data;
        });
      } else {
        final apiData = await fetchGategoreData();
        setState(() {
          gategoreData = apiData;
        });
        saveDataToSharedPreferences(apiData);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<Map<String, dynamic>?> getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('gategoreData');

    if (jsonData != null) {
      return json.decode(jsonData);
    }

    return null;
  }

  Future<void> saveDataToSharedPreferences(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gategoreData', json.encode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gategore App'),
      ),
      body: Center(
        child: gategoreData == null
            ? CircularProgressIndicator()
            : GategoreDataWidget(data: gategoreData!),
      ),
    );
  }
}

class GategoreDataWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  GategoreDataWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Gategore Data: $data'),
    );
  }
}

Future<Map<String, dynamic>> fetchGategoreData() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/Gategore'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Gategore data: ${response.statusCode}');
  }
}
