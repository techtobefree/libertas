import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/cubits/domain/groups/cubit.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';
import 'package:serve_to_be_free/widgets/find_project_card.dart';
import 'package:serve_to_be_free/widgets/group_card.dart';

class FindAGroup extends StatefulWidget {
  const FindAGroup({super.key});

  @override
  State<FindAGroup> createState() => _FindAGroupState();
}

class _FindAGroupState extends State<FindAGroup> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GroupsCubit>(context).loadGroups();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Find a Group',
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
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
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
                    hintText: 'Search by group name',
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
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<GroupsCubit, GroupsCubitState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.busy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final groups = state.groups.toList();
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, i) {
              // print(_searchQuery.toLowerCase());
              if (_searchQuery.length < 2) {
                return GroupCard.fromUGroup(groups[i]);
                // return ProjectCard.fromUProject(incompleteProjects[i]);
              } else {
                final name = groups[i].name.toLowerCase();
                final query = _searchQuery.toLowerCase();
                if (name.contains(query)) {
                  return GroupCard.fromUGroup(groups[i]);
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
