import 'dart:convert';
import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/projects/project_handlers.dart';
import 'package:serve_to_be_free/widgets/buttons/solid_rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../data/users/handlers/user_handlers.dart';
import '../../data/users/providers/user_provider.dart';
import '../../models/ModelProvider.dart';

class CreateAPost extends StatefulWidget {
  const CreateAPost({Key? key}) : super(key: key);

  @override
  _CreateAPostState createState() => _CreateAPostState();
}

class _CreateAPostState extends State<CreateAPost> {
  final _textEditingController = TextEditingController();
  Map<String, dynamic> _selectedOption = {
    'name': 'Projects',
    'url': null,
    'id': ""
  };
  bool _isLoading = false;
  List<Map<String, dynamic>>? _options;

  Future<List<Map<String, dynamic>>> _getOptions() async {
    try {
      var projs = await ProjectHandlers.getMyProjects(
          Provider.of<UserProvider>(context, listen: false).id);
      List<Map<String, dynamic>> myprojs = [];
      for (var proj in projs) {
        myprojs.add({
          'name': proj['name'],
          'url': proj['projectPicture'],
          'id': proj['id']
        });
      }
      return myprojs;
    } catch (exp) {
      throw Exception('Failed to load projects');
    }
  }

  Widget _buildListTile(Map<String, dynamic> option, int index,
      Function setStateCallback, BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.asset(
          option['image'],
          fit: BoxFit.cover,
          height: 30,
          width: 30,
        ),
      ),
      title: Text(option['text']),
      onTap: () {
        setStateCallback(() {
          _selectedOption = option;
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Post'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 28, 72, 1.0),
                  Color.fromRGBO(35, 107, 140, 1.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      //padding: EdgeInsets.all(5),
                      child: _selectedOption['url'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                _selectedOption['url'],
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.group_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.amberAccent,
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () {
                        _showOptionsDialog(); // Show the options dialog
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              _selectedOption['name'],
                            ), // Display the selected option
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines:
                        null, // This will allow the text area to expand to fit the content.
                    decoration: InputDecoration(
                        hintText:
                            'Enter your text here', // Placeholder text for the text area
                        border: InputBorder.none // Border around the text area
                        ),
                  )),
              //Spacer(),
              SolidRoundedButton("Post",
                  passedFunction: () => {
                        if (_selectedOption['id'] != "")
                          {_postToApi(_selectedOption['id'])}
                      })
            ],
          ),
        ));
  }

  void _postToApi(projId) async {
    final text = _textEditingController.text;

    // Make sure the text field is not empty
    if (text.isEmpty) {
      return;
    }
    UProject? uproject = await ProjectHandlers.getUProjectById(projId);
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
      context.go('/dashboard');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  void _showOptionsDialog() async {
    setState(() {
      _isLoading = true;
    });

    final options = await _getOptions();

    setState(() {
      _isLoading = false;
      _options = options;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _isLoading ? 0.0 : 1.0,
          child: Stack(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: _options?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child:

                            //padding: EdgeInsets.all(5),
                            Image.network(
                          _options?[index]['url'] ?? "",
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        )),
                    title: Text(_options?[index]['name'] ?? ""),
                    onTap: () {
                      setState(() {
                        _selectedOption = _options![index];
                      });
                    },
                  );
                },
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
