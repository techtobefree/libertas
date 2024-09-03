import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
//import 'package:serve_to_be_free/utilities/user_model.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';
import 'package:http/http.dart' as http;

import 'package:serve_to_be_free/data/projects/project_handlers.dart';

class ProjectPostDialog extends StatefulWidget {
  final String projectId;
  const ProjectPostDialog({super.key, required this.projectId});

  @override
  ProjectPostDialogState createState() => ProjectPostDialogState();
}

class ProjectPostDialogState extends State<ProjectPostDialog> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: "Enter text to post",
                hintStyle: TextStyle(fontSize: 12.0),
              ),
            ),
            FormBuilderImagePicker(
              name: "postPicture",
              decoration: const InputDecoration(
                labelText: 'Post Image (optional)',
                labelStyle: TextStyle(fontSize: 16.0),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide.none,
                // ),
              ),
              // validator: FormBuilderValidators.compose([
              //   FormBuilderValidators.required(),
              // ]),
              // fit: BoxFit.cover,
              maxImages: 1,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () =>
              postButtonPress(BlocProvider.of<UserCubit>(context).state.id),
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

  void postButtonPress(String userId) async {
    final String text = _textController.text;
    if (text != '') {
      if (_formKey.currentState!.saveAndValidate()) {
        final formData = _formKey.currentState!.value;
        await addPost(formData, text, userId);
      }
    }
    Navigator.of(context).pop();
    context.goNamed("projectdetails",
        queryParameters: {'id': widget.projectId},
        pathParameters: {'id': widget.projectId});
  }

  Future<String> uploadImageToS3(
      File imageFile, String bucketName, String projName, String timestamp,
      {String region = 'us-east-1'}) async {
    final key = '/ProjectImages/$projName/$timestamp';
    final url = 'https://servetobefree-images-dev.s3.amazonaws.com/$key'
        .replaceAll('+', '%20');
    final response = await http.put(Uri.parse(url),
        headers: {'Content-Type': 'image/jpeg'},
        body: await imageFile.readAsBytes());
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to S3');
    }
    return url;
  }

  Future<void> addPost(
      Map<String, dynamic> formData, String text, String userId) async {
    UProject? uproject =
        await ProjectHandlers.getUProjectById(widget.projectId);
    var uprojectPosts = uproject!.posts;
    var uuser = await UserHandlers.getUUserById(userId);
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString();

    const bucketName = 'servetobefree-images-dev';
    const region = 'us-east-1';
    const url = 'https://$bucketName.s3.$region.amazonaws.com';

    var finalUrl = "";

    if (formData['postPicture'] != null && formData['postPicture'].length > 0) {
      final selectedFile = formData['postPicture'][0];

      if (selectedFile != null) {
        if (selectedFile != imageCache) {
          final file = File(selectedFile.path);

          finalUrl = await uploadImageToS3(
              file, 'servetobefree-images', userId, timestamp);
        }
      }
    }
    print(finalUrl);

    var upost = UPost(
        user: uuser!,
        content: text,
        postPicture: finalUrl,
        project: uproject,
        date:
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    final request = ModelMutations.create(upost);
    final response = await Amplify.API.mutate(request: request).response;

    if (uprojectPosts == null) {
      uprojectPosts = [response.data!];
    } else {
      uprojectPosts.add(response.data!);
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
