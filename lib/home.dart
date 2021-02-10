import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'post.dart';
import 'create_post.dart';
import 'read_posts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, I\'m Matthew.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'I\'m 17 years old.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      'Yo what\'s up?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: RaisedButton.icon(
              onPressed: () {
                Navigator.of(context).push<void>(SwipeablePageRoute(
                  builder: (_) => ReadPosts(),
                ));
              },
              icon: Icon(
                Icons.arrow_forward,
              ),
              label: Text("Read Existing Posts"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: RaisedButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push<void>(SwipeablePageRoute(
                  builder: (_) => CreatePost(),
                ));
              },
              icon: Icon(
                Icons.arrow_forward,
              ),
              label: Text("Create a New Post"),
            ),
          ),
        ],
      )),
    );
  }
}

Future<List<String>> getUsers() async {
  Post user = await fetchPost();
  return [user.title, user.body.toString()];
}
