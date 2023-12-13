import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

class FindAProject extends StatefulWidget {
  const FindAProject({super.key});

  @override
  State<FindAProject> createState() => _FindAProjectState();
}

class _FindAProjectState extends State<FindAProject> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProjectsCubit>(context).loadProjects();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text('Find a Project'),
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
        ),
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Column(
              children: [
                const SizedBox(height: 5.0),
                TextField(
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by location',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.grey[700]!, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.grey[700]!, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProjectsCubit, ProjectsCubitState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final incompleteProjects = state.incompleteProjects.toList();
          return ListView.builder(
            itemCount: incompleteProjects.length,
            itemBuilder: (context, i) {
              // print(_searchQuery.toLowerCase());
              if (_searchQuery.length < 2) {
                return ProjectCard.fromUProject(incompleteProjects[i]);
              } else {
                final city = incompleteProjects[i].city?.toLowerCase() ?? '';
                final usaState =
                    incompleteProjects[i].state?.toLowerCase() ?? '';
                final combined = '$city, $usaState';
                final query = _searchQuery.toLowerCase();
                if (city.contains(query) ||
                    usaState.contains(query) ||
                    combined.contains(query)) {
                  return ProjectCard.fromUProject(incompleteProjects[i]);
                }
                return const SizedBox
                    .shrink(); // or return null; to hide the card
              }
            },
          );
        },
      ),
    );
  }

  // Future<List<dynamic>> getProjects() async {
  //   var url = Uri.parse('http://44.203.120.103:3000/projects');
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     // print(jsonResponse);
  //     return jsonResponse;
  //   } else {
  //     throw Exception('Failed to load projects');
  //   }
  // }
}
