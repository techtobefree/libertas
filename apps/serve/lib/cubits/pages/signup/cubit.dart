import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ));
}
