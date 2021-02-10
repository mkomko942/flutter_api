import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'post.dart';

class CreatePost extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController bodyController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Create New Post')
      ),
      body: ListView(
        children: [
          Text(
            'Create a new post',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Title cannot be empty';
                                }
                                return null;
                              },
                              maxLength: 30,
                              decoration:
                                  InputDecoration(hintText: 'Enter a title'),
                              controller: titleController,
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Title cannot be empty';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.deny('\n'),
                              ],
                              maxLength: 250,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: 'Start typing here'),
                              controller: bodyController,
                            )),
                      ]))),
          Padding(
            padding: EdgeInsets.all(25),
            child: RaisedButton.icon(
              color: Colors.deepPurple[400],
              onPressed: () {
                HapticFeedback.lightImpact();
                if (_formKey.currentState.validate()) {
                  createPost(titleController.text, bodyController.text);
                  titleController.clear();
                  bodyController.clear();
                  postSnackBar();
                }
              },
              icon: Icon(
                Icons.add,
              ),
              label: Text("Post"),
            ),
          ),
        ],
      ),
    );
  }

  void postSnackBar() {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text("Post Created"),
    ));
  }
}
