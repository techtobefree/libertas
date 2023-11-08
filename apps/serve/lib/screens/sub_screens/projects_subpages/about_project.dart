import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:serve_to_be_free/data/users/providers/user_provider.dart';
import 'package:serve_to_be_free/models/ModelProvider.dart';

class AboutProject extends StatefulWidget {
  final String? id;

  const AboutProject({Key? key, required this.id}) : super(key: key);

  @override
  AboutProjectState createState() => AboutProjectState();
}

class AboutProjectState extends State<AboutProject> {
  Map<String, dynamic> projectData = {};

  Future<Map<String, dynamic>> getProject() async {
    final queryPredicate = UProject.ID.eq(widget.id);

    final request = ModelQueries.list<UProject>(
      UProject.classType,
      where: queryPredicate,
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.data!.items.isNotEmpty) {
      var jsonResponse = response.data!.items[0]!.toJson();

      return jsonResponse;
    } else {
      throw Exception('Failed to load projects');
    }
  }

  @override
  void initState() {
    super.initState();
    getProject().then((data) {
      setState(() {
        projectData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider or UserClass?
    final currentUserID = Provider.of<UserProvider>(context, listen: false).id;
    // TODO: final currentUserID =  BlocProvider.of<UserCubit>(context).state.id;

    final members = projectData['members'] ?? [];
    final leader = projectData['leader'];

    // unused
    //final hasJoined = members.contains(currentUserID);
    //final joinButtonText = hasJoined ? 'Post' : 'Join';

    bool shouldDisplayEditButton = false;

    if (members.length > 0) {
      shouldDisplayEditButton =
          (((members[0] ?? '') == currentUserID) || leader == currentUserID);
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Project Dashboard'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 28, 72, 1.0),
                  Color.fromRGBO(35, 107, 140, 1.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: shouldDisplayEditButton,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 16, 34, 65),
                      ),
                    ),
                    onPressed: () {
                      // Handle the edit button press here
                      context.goNamed(
                        'projectdetailsform',
                        queryParameters: {
                          'id': projectData['id'],
                        },
                      );
                    },
                    child: const Text('Edit Project'),
                  ),
                ),
                if (projectData.containsKey('projectPicture') &&
                    projectData['projectPicture'].isNotEmpty)
                  Image.network(
                    projectData['projectPicture'],
                    fit: BoxFit.cover, // adjust the image to fit the widget
                    width: 300, // set the width of the widget
                    height: 300, // set the height of the widget
                  ),
                const SizedBox(height: 20),
                Text(
                  projectData['name'] ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                if (projectData.containsKey('bio'))
                  Text('${projectData['bio']}'),
                const SizedBox(height: 10),
                if (projectData.containsKey('description'))
                  Text('${projectData['description']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
