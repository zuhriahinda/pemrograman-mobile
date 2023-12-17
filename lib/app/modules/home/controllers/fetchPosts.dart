import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;

  Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

Future<Posts> fetchPosts(http.Client client, String invalidURL) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    // If the server does not return a 200 OK response, throw an exception
    throw Exception('Failed to load posts');
  }
}
