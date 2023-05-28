import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

//import 'package:serve_to_be_free/utilities/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';

class JoinProjectDialog extends StatefulWidget {
  final String projectId;

  JoinProjectDialog({required this.projectId});
  @override
  _JoinProjectDialogState createState() => _JoinProjectDialogState();
}

class _JoinProjectDialogState extends State<JoinProjectDialog> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(hintText: "Enter text to post"),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => postButtonPress(),
          child: Text("Post"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void postButtonPress() async {
    final String text = _textController.text;
    if (text != '') {
      await addPost(text);
    }
    Navigator.of(context).pop();
  }

  Future<void> addPost(text) async {
    final url = Uri.parse(
        // 'http://44.203.120.103:3000/projects/${widget.projectId}/post');
        'http://44.203.120.103:3000/projects/${widget.projectId}/post');
    final Map<String, dynamic> data;
    print(Provider.of<UserProvider>(context, listen: false).profilePictureUrl);
    if (Provider.of<UserProvider>(context, listen: false).profilePictureUrl !=
        '') {
      data = {
        'member': Provider.of<UserProvider>(context, listen: false).id,
        'name':
            "${Provider.of<UserProvider>(context, listen: false).firstName} ${Provider.of<UserProvider>(context, listen: false).lastName}",
        'text': text,
        'imageUrl':
            Provider.of<UserProvider>(context, listen: false).profilePictureUrl
      };
    } else {
      data = {
        'member': Provider.of<UserProvider>(context, listen: false).id,
        'name':
            "${Provider.of<UserProvider>(context, listen: false).firstName} ${Provider.of<UserProvider>(context, listen: false).lastName}",
        'text': text
      };
    }
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(response.toString());

    if (response.statusCode == 200) {
      // API call successful\
      // setState(() {
      //   projectData['members'] = projectData['members'] != null
      //       ? [...projectData['members'], data['memberId']]
      //       : [data['memberId']];
      // });
    } else {
      // API call unsuccessful
      print('Failed to fetch data');
    }
  }
}
