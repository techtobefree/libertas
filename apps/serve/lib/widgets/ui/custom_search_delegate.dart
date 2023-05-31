import 'package:flutter/material.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';
import 'package:serve_to_be_free/widgets/User_invite_display.dart';

//import '../classes/UserClass_old.dart';

class CustomSearchDelegate extends SearchDelegate {
  /* This can get a list of UserClasss, for example we 
  just want leaders who might be friends with the UserClass. 
  Or maybe just UserClasss to invite to participate in a task.

  Should be late because we dont have access yet right?
  */
  late List<UserClass> potentialUserClasss;

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query:
            '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Need to display the UserClass with all the info
    List<UserClass> matchQuery = [];
    for (var UserClass in potentialUserClasss) {
      var fullName = UserClass.firstName + UserClass.lastName;
      if ((fullName).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(UserClass);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return UserInviteDisplay(user: result);
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Need to display the UserClass with all the info
    List<UserClass> matchQuery = [];
    for (var UserClass in potentialUserClasss) {
      var fullName = UserClass.firstName + UserClass.lastName;
      //if ((UserClass.name).toLowerCase().contains(query.toLowerCase())) {
      if ((fullName).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(UserClass);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return UserInviteDisplay(user: result);
      }),
    );
  }
}
