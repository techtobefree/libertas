import 'package:flutter/material.dart';
//import 'package:serve_to_be_free/widgets/classes/UserClass_old.dart'art';
import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';

class UserInviteDisplay extends StatelessWidget {
  const UserInviteDisplay({
    super.key,
    required UserClass user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          /*
        user.borderColor
        user.profileImage
        */

          const Row(children: [ProfilePicture(Colors.pinkAccent, 10, '', '')]),
    );
  }
}
