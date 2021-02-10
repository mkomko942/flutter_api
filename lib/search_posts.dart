import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'post.dart';
import 'create_post.dart';

import 'package:flutter/material.dart';

class SearchPosts extends StatefulWidget {
  @override
  _SearchPostsState createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  TextEditingController _searchQueryController = TextEditingController();

  Future<List<Widget>> posts;

  @override
  void initState() {
    super.initState();

    posts = fetchCards(_searchQueryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: _buildSearchField()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: RefreshIndicator(
              backgroundColor: Colors.white70,
              color: Colors.deepPurple[400],
              onRefresh: () async {
                setState(() {
                  posts = fetchCards(_searchQueryController.text);
                });
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FutureBuilder<List<Widget>>(
                      future: posts,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Widget>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView(children: snapshot.data);
                        } else {
                          return Center(
                            child: SpinKitRing(
                              color: Colors.deepPurple[400],
                              size: 35.0,
                              lineWidth: 3,
                            ),
                          );
                        }
                      }))),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push<void>(SwipeablePageRoute(
              builder: (_) => CreatePost(),
            ));
          },
        ));
  }

  Widget _buildSearchField() {
    return Container(
        height: AppBar().preferredSize.height - 10,
        child: TextField(
          autofocus: false,
          style: TextStyle(color: Colors.white),
          controller: _searchQueryController,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Tap to search",
            hintStyle: TextStyle(color: Colors.white60),
          ),
          onChanged: _startSearch,
        ));
  }

  void _startSearch(term) {
    setState(() {
      posts = fetchCards(_searchQueryController.text);
    });
  }

  Widget postCard(post) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 2, color: Colors.deepPurple[400])),
          color: const Color(0x337E57C2),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                        color: Colors.deepPurple[400],
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
      return [Center(child: Text('Found no matching posts'))];
    }
    return cards;
  }

  Future<List<Widget>> fetchCards(String searchterm) async {
    var data = await fetchSearchPost(searchterm);
    return createCards(data);
  }
}