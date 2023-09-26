import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';

//import 'package:serve_to_be_free/utilities/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

import '../data/projects/project_handlers.dart';

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
    UProject? uproject =
        await ProjectHandlers.getUProjectById(widget.projectId);
    var uprojectPosts = uproject!.posts;
    var uuser = await UserHandlers.getUUserById(
        Provider.of<UserProvider>(context, listen: false).id);
    DateTime now = DateTime.now();
    var upost = UPost(
        user: uuser!,
        content: text,
        date:
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    final request = ModelMutations.create(upost);
    final response = await Amplify.API.mutate(request: request).response;

    if (uprojectPosts == null) {
      uprojectPosts = [response.data!.id];
    } else {
      uprojectPosts.add(response.data!.id);
    }

    final addedPostUProj = uproject.copyWith(posts: uprojectPosts);

    try {
      final request = ModelMutations.update(addedPostUProj);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
