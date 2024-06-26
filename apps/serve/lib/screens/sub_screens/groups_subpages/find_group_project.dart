import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/projects/cubit.dart';
import 'package:serve_to_be_free/data/groups/group_handlers.dart';
import 'package:serve_to_be_free/widgets/find_group_project_card.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';

import '../../../models/ModelProvider.dart';

class FindAGroupProject extends StatefulWidget {
  final String? id;

  const FindAGroupProject({Key? key, required this.id}) : super(key: key);
  @override
  State<FindAGroupProject> createState() => _FindAGroupProjectState();
}

class _FindAGroupProjectState extends State<FindAGroupProject> {
  String _searchQuery = '';
  var groupProjs = [];

  @override
  void initState() {
    super.initState();

    getGroupMembers(widget.id).then((data) {
      setState(() {
        groupProjs = data;
      });
    });
  }

  Future<List<String>> getGroupMembers(id) async {
    UGroup? group = await GroupHandlers.getUGroupById(id);
    if (group != null) {
      return group.projects!;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProjectsCubit>(context).loadProjects();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Find a Project',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushNamed("groupproject", queryParameters: {
              'id': widget.id,
            }, pathParameters: {
              'id': widget.id!,
            });
          },
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
          var incompleteProjects = state.incompleteProjects.toList();
          var projsNotInGroup = [];
          for (var proj in incompleteProjects) {
            if (!groupProjs.contains(proj.id)) {
              projsNotInGroup.add(proj);
            }
          }
          return ListView.builder(
            itemCount: projsNotInGroup.length,
            itemBuilder: (context, i) {
              // print(_searchQuery.toLowerCase());
              if (_searchQuery.length < 2) {
                return FindGroupProjectCard(
                    title: projsNotInGroup[i].name,
                    numMembers: projsNotInGroup[i].members!.length.toString(),
                    project: projsNotInGroup[i].toJson(),
                    sponsors: projsNotInGroup[i].sponsors ?? [],
                    groupId: widget.id!);
              } else {
                final city = projsNotInGroup[i].city?.toLowerCase() ?? '';
                final usaState = projsNotInGroup[i].state?.toLowerCase() ?? '';
                final combined = '$city, $usaState';
                final query = _searchQuery.toLowerCase();
                if (city.contains(query) ||
                    usaState.contains(query) ||
                    combined.contains(query)) {
                  return FindGroupProjectCard(
                      title: projsNotInGroup[i].name,
                      numMembers: projsNotInGroup[i].members!.length.toString(),
                      project: projsNotInGroup[i].toJson(),
                      sponsors: projsNotInGroup[i].sponsors ?? [],
                      groupId: widget.id!);
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
}
