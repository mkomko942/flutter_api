import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourAwesomeApp',
      home: PageWithAnimatedList(),
    );
  }
}

class PageWithAnimatedList extends StatefulWidget {
  @override
  _PageWithAnimatedListState createState() => _PageWithAnimatedListState();
}

class _PageWithAnimatedListState extends State<PageWithAnimatedList> {
  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  void _loadItems() {
    // fetching data from web api, db...
    final fetchedList = [
      ListTile(
        title: Text('Economy'),
        trailing: Icon(Icons.directions_car),
      ),
      ListTile(
        title: Text('Comfort'),
        trailing: Icon(Icons.motorcycle),
      ),
      ListTile(
        title: Text('Business'),
        trailing: Icon(Icons.flight),
      ),
    ];

    var future = Future(() {});
    for (var i = 0; i < fetchedList.length; i++) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 100), () {
          _listItems.add(fetchedList[i]);
          _listKey.currentState.insertItem(_listItems.length - 1);
        });
      });
    }
  }

  void _unloadItems() {
    var future = Future(() {});
    for (var i = _listItems.length - 1; i >= 0; i--) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 100), () {
          final deletedItem = _listItems.removeAt(i);
          _listKey.currentState.removeItem(i,
              (BuildContext context, Animation<double> animation) {
            return SlideTransition(
              position: CurvedAnimation(
                curve: Curves.easeOut,
                parent: animation,
              ).drive((Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ))),
              child: deletedItem,
            );
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: _loadItems),
          IconButton(icon: Icon(Icons.remove), onPressed: _unloadItems)
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        padding: EdgeInsets.only(top: 10),
        initialItemCount: _listItems.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: CurvedAnimation(
              curve: Curves.easeOut,
              parent: animation,
            ).drive((Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset(0, 0),
            ))),
            child: _listItems[index],
          );
        },
      ),
    );
  }
}
