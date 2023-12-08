import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_to_be_free/data/users/models/user_class.dart';

part 'state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(const SignupState());

  void reset() => emit(const SignupState());

  void update({
    String? id,
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    String? bio,
    String? profilePictureUrl,
    File? profilePicture,
    SignUpResult? signUpResult,
    bool? imageBusy,
    bool? signingUpBusy,
  }) =>
      emit(SignupState(
        id: id ?? state.id,
        email: email ?? state.email,
        password: password ?? state.password,
        confirmPassword: confirmPassword ?? state.confirmPassword,
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        bio: bio ?? state.bio,
        profilePictureUrl: profilePictureUrl ?? state.profilePictureUrl,
        profilePicture: profilePicture ?? state.profilePicture,
        signUpResult: signUpResult ?? state.signUpResult,
        imageBusy: imageBusy ?? state.imageBusy,
        signingUpBusy: signingUpBusy ?? state.signingUpBusy,
      ));

  Future<void> signUpCognito({
    required String password,
    required String email,
  }) async {
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
    update(signUpResult: result);
    await _handleSignUpResult(result);
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }
}
