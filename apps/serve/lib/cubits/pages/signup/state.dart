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

  const SignupState({
    this.id = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
    this.profilePictureUrl = '',
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
      ];
}
