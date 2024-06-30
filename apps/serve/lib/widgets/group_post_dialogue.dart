import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
//import 'package:serve_to_be_free/utilities/user_model.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

import 'package:serve_to_be_free/data/groups/group_handlers.dart';

class GroupPostDialog extends StatefulWidget {
  final String groupId;
  const GroupPostDialog({super.key, required this.groupId});

  @override
  GroupPostDialogState createState() => GroupPostDialogState();
}

class GroupPostDialogState extends State<GroupPostDialog> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _textController,
        decoration: const InputDecoration(hintText: "Enter text to post"),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => postButtonPress(),
          child: const Text("Post"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
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
    UGroup? ugroup = await GroupHandlers.getUGroupById(widget.groupId);
    var ugroupPosts = ugroup!.posts;
    var uuser = await UserHandlers.getUUserById(
        BlocProvider.of<UserCubit>(context).state.id);
    DateTime now = DateTime.now();
    var upost = UPost(
        user: uuser!,
        content: text,
        date:
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    final request = ModelMutations.create(upost);
    final response = await Amplify.API.mutate(request: request).response;

    if (ugroupPosts == null) {
      ugroupPosts = [response.data!.id];
    } else {
      ugroupPosts.add(response.data!.id);
    }

    final addedPostUGroup = ugroup.copyWith(posts: ugroupPosts);

    try {
      final request = ModelMutations.update(addedPostUGroup);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Response: $response');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
