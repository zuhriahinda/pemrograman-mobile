import 'package:flutter/material.dart';
import 'package:flutter_application_1/API.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class TodosPage extends StatefulWidget {
  @override
  _TodosPage createState() => _TodosPage();
}

class _TodosPage extends State<TodosPage> {
  ArticlesResult? _articlesResult;

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _articlesResult = ArticlesResult.fromJson(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pengunjung'),
      ),
      body: Center(
        child: _articlesResult == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _articlesResult!.data.length,
                itemBuilder: (context, index) {
                  final datum = _articlesResult!.data[index];
                  return ListTile(
                    title: Text('Name: ${datum.firstName} ${datum.lastName}'),
                    subtitle: Text('Email: ${datum.email}'),
                    leading: Image.network(datum.avatar),
                  );
                },
              ),
      ),
    );
  }
}
