import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'post.dart';
import 'create_post.dart';
import 'search_posts.dart';

import 'package:flutter/material.dart';

class RefreshFutureBuilder extends StatefulWidget {
  @override
  _RefreshFutureBuilderState createState() => _RefreshFutureBuilderState();
}

class _RefreshFutureBuilderState extends State<RefreshFutureBuilder> {
  Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All posts")),
      body: FutureBuilder<List<Post>>(
          future: posts,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return createCards(snapshot.data);
            } else {
              return Center(
                child: SpinKitRing(
                  color: Colors.deepPurple,
                  size: 35.0,
                  lineWidth: 3,
                ),
              );
            }
          }),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.deepPurple[400],
        onOpen: () => HapticFeedback.lightImpact(),
        onClose: () => HapticFeedback.lightImpact(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.refresh),
              backgroundColor: Colors.deepPurple[400],
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  posts = fetchAllPosts();
                });
              }),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepPurple[400],
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push<void>(SwipeablePageRoute(
                builder: (_) => CreatePost(),
              ));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.search),
            backgroundColor: Colors.deepPurple[400],
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).push<void>(SwipeablePageRoute(
                builder: (_) => SearchPosts(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

Widget postCard(post) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(
                      color: Colors.amber[400],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      post.body,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))
              ],
            )),
      ));
}

Widget createCards(data) {
  List<Widget> cards = [];
  for (var post in data) {
    cards.add(postCard(post));
  }
  if (cards.isEmpty) {
    return Center(child: Text('There are no posts.'));
  }
  return ListView(children:cards);
}
