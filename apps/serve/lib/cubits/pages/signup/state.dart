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
  final File? profilePicture;
//final SignUpResult signUpResult; // import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
  final SignUpResult signUpResult;
  final String confirmationCode;
  final bool imageBusy;
  final bool signingUpBusy;
  const SignupState({
    this.id = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    this.profilePictureUrl = '',
    this.profilePicture,
    this.signUpResult = const SignUpResult(
      isSignUpComplete: false,
      nextStep: AuthNextSignUpStep(signUpStep: AuthSignUpStep.done),
      userId: null,
    ),
    this.confirmationCode = '',
    this.imageBusy = false,
    this.signingUpBusy = false,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        bio,
        profilePictureUrl,
        profilePicture,
        signUpResult,
        confirmationCode,
        imageBusy,
        signingUpBusy,
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
