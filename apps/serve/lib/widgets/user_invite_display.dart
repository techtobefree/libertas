import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
//import 'package:serve_to_be_free/widgets/classes/UserClass_old.dart'art';

import 'package:serve_to_be_free/widgets/profile_picture.dart';
import 'package:image_picker/image_picker.dart';

import '../data/users/models/user_class.dart';

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

          Row(children: [ProfilePicture(Colors.pinkAccent, 10, '', '')]),
    );
  }
}
