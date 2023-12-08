part of 'cubit.dart';

class SignupState extends Equatable {
  final String id;
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String bio;
  final String profilePictureUrl;
//final SignUpResult signUpResult; // import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
  final SignUpResult signUpResult;

  const SignupState({
    this.id = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    this.profilePictureUrl = '',
    this.signUpResult = const SignUpResult(
      isSignUpComplete: false,
      nextStep: AuthNextSignUpStep(signUpStep: AuthSignUpStep.done),
      userId: null,
    ),
  });

  @override
  List<Object> get props => [
        id,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        bio,
        profilePictureUrl,
        signUpResult,
      ];

  UserClass get user => UserClass(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      projects: [],
      bio: '',
      profilePictureUrl: '',
      coverPictureUrl: '',
      isLeader: false,
      friends: [],
      friendRequests: [],
      posts: []);
}
