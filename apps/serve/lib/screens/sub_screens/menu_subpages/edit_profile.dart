import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/data/users/handlers/user_handlers.dart';
import 'package:serve_to_be_free/cubits/domain/user/cubit.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController bioController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  void initState() {
    super.initState();
    firstNameController.text =
        BlocProvider.of<UserCubit>(context).state.firstName;
    lastNameController.text =
        BlocProvider.of<UserCubit>(context).state.lastName;
    bioController.text = BlocProvider.of<UserCubit>(context).state.bio;
    cityController.text = BlocProvider.of<UserCubit>(context).state.city;
    stateController.text = BlocProvider.of<UserCubit>(context).state.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
              maxLines: 3, // Allowing multiple lines for bio
            ),
            SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 16, 34, 65),
                ),
              ),
              onPressed: () {
                // Access user input using controllers
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;

                String bio = bioController.text;
                String city = cityController.text;
                String state = stateController.text;

                UserHandlers.modifyUser(
                    BlocProvider.of<UserCubit>(context).state.id,
                    firstName: firstName,
                    lastName: lastName,
                    bio: bio,
                    city: city,
                    state: state);

                BlocProvider.of<UserCubit>(context).update(
                    firstName: firstName,
                    lastName: lastName,
                    bio: bio,
                    city: city,
                    stateStr: state);

                context.go('/menu/myprofile');
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
