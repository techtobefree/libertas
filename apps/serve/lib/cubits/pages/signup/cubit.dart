import 'dart:io';
import 'dart:typed_data';
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
    String? confirmationCode,
    bool? imageBusy,
    bool? signingUpBusy,
    bool? confirmBusy,
    Uint8List? webImage,
    bool? hasSelectedImage,
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
        confirmationCode: confirmationCode ?? state.confirmationCode,
        imageBusy: imageBusy ?? state.imageBusy,
        signingUpBusy: signingUpBusy ?? state.signingUpBusy,
        confirmBusy: confirmBusy ?? state.confirmBusy,
        webImage: webImage ?? state.webImage,
        hasSelectedImage: hasSelectedImage ?? state.hasSelectedImage,
      ));

  Future<void> signUpCognito({
    String? password,
    String? email,
  }) async {
    final result = await Amplify.Auth.signUp(
      username: email ?? state.email,
      password: password ?? state.password,
    );
    update(signUpResult: result);
    await _handleSignUpResult(result);
  }

  Future<void> resetPassword(String username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      await _handleResetPasswordResult(result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthResetPasswordStep.done:
        safePrint('Successfully reset password');
        break;
    }
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      safePrint('Error fetching user attributes: ${e.message}');
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
    }
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

  Future<bool> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: state.email,
        confirmationCode: state.confirmationCode,
      );
      print(result);
      // Check if further confirmations are needed or if
      // the sign up is complete.
      if (result.isSignUpComplete == false) {
        return false;
      }
      update(signUpResult: result);
      safePrint('sign up complete');
      return true;
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
      return false;
    }
  }
}
