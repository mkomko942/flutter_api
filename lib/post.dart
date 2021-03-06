import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Post {
  final String title;
  final String body;
  final String likes;
  final String date;

  Post({this.title, this.body, this.likes, this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    final int millisecondsUTC = json['date'].round() * 1000;
    final DateTime localDate =
        DateTime.fromMillisecondsSinceEpoch(millisecondsUTC, isUtc: true)
            .toLocal();
    final DateFormat formatter = DateFormat.yMd().add_jm();
    formatter.format(localDate);
    return Post(
      title: json['title'],
      body: json['body'],
      likes: json['likes'].toString(),
      date: formatter.format(localDate),
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get('https://flask-api.matthewtao1.repl.co');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

Future<bool> createPost(String title, String body) async {
  final response = await http.post(
    'https://flask-api.matthewtao1.repl.co',
    body: jsonEncode(<String, String>{
      'title': title,
      'body': body,
    }),
  );
  if (response.statusCode == 200) {
    return Future<bool>.value(true);
  } else {
    return Future<bool>.value(false);
  }
}

Future<List<Post>> fetchAllPosts() async {
  final response =
      await http.get('https://flask-api.matthewtao1.repl.co/posts');
  List<Post> allPosts = [];
  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    for (var key in jsonResponse.keys) {
      try {
        allPosts.add(Post.fromJson(jsonResponse[key]));
      } on Exception catch (_) {
        throw Exception("Error on server");
      }
    }
  } else {
    throw Exception('Failed to load user');
  }
  return allPosts;
}

Future<List<Post>> fetchSearchPost(String searchterm) async {
  if (searchterm.isEmpty) {
    return fetchAllPosts();
  }
  final response = await http
      .get('https://flask-api.matthewtao1.repl.co/search/$searchterm');
  List<Post> allPosts = [];
  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    for (var key in jsonResponse.keys) {
      try {
        allPosts.add(Post.fromJson(jsonResponse[key]));
      } on Exception catch (_) {
        throw Exception("Error on server");
      }
    }
  } else {
    throw Exception('Failed to load user');
  }
  return allPosts;
}
