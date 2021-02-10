import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'refresh.dart';
import 'post.dart';

class ReadPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posts',)
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: FutureBuilder(
              future: fetchAllPosts(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                if (snapshot.hasData) {
                  print("hi");
                  return ListView(children: createCards(snapshot.data));
                } else {
                  print("bye");
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitRing(
                          color: Colors.deepPurple,
                          size: 35.0,
                          lineWidth: 3,
                        ),
                      ]);
                }
              },
            )),
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push<void>(SwipeablePageRoute(
            builder: (_) => RefreshFutureBuilder(),
          ));
        },
        label: Text('Create a New Post'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
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

List<Widget> createCards(data) {
  List<Widget> cards = [];
  for (var post in data) {
    cards.add(postCard(post));
  }
  if (cards.isEmpty) {
    cards.add(Text('There are no posts'));
  }
  return cards;
}
