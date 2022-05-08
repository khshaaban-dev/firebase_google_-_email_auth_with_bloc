import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_clone/data/exeptions/auth_exceptions.dart';
import 'package:tiktok_clone/data/repostories/auth_repostory.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepostory _authRepostory;
  AuthBloc({AuthRepostory? authRepostory})
      : _authRepostory = authRepostory ?? AuthRepostory(),
        super(UnAuthanticatedState()) {
    on<IntitlizeEvent>((event, emit) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          emit(AuthanticatedState());
        } else {
          emit(UnAuthanticatedState());
        }
      } catch (e) {
        emit(UnAuthanticatedState());
      }
    });

    on<GoToSignUpScreenEvent>((event, emit) {
      emit(IsInSignUpScreenState());
      // emit(UnAuthanticatedState());
    });
    on<GoToSignInScreenEvent>((event, emit) {
      emit(UnAuthanticatedState());
    });
    on<SignUpEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await _authRepostory.signUp(
          email: event.email,
          password: event.password,
        );
        emit(AuthanticatedState());
      } on AuthError catch (e) {
        emit(
          AuthErrorState(
            authError: e,
          ),
        );
        emit(UnAuthanticatedState());
      }
    });
    on<SignInEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await _authRepostory.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthanticatedState());
      } on AuthError catch (e) {
        emit(
          AuthErrorState(
            authError: e,
          ),
        );
        emit(UnAuthanticatedState());
      }
    });
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await _authRepostory.signInWithGoogle();
        emit(AuthanticatedState());
      } on AuthError catch (e) {
        emit(
          AuthErrorState(
            authError: e,
          ),
        );
        emit(UnAuthanticatedState());
      }
    });
    on<SignOutEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await _authRepostory.signOut();
        emit(UnAuthanticatedState());
      } on AuthError catch (e) {
        emit(
          AuthErrorState(
            authError: e,
          ),
        );
        emit(AuthanticatedState());
      }
    });
  }
}
