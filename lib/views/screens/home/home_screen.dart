import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/logic/blocs/auth/auth_bloc.dart';
import 'package:tiktok_clone/views/dialogs/show_auth_error.dart';
import 'package:tiktok_clone/views/loading/loading_screen.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state is LoadingState) {
          //   LoadingScreen.instance().show(
          //     context: context,
          //     text: 'Loading...',
          //   );
          // } else {
          //   LoadingScreen.instance().hide();
          // }
          // if (state is UnAuthanticatedState) {
          //   Navigator.pushReplacementNamed(
          //     context,
          //     LoginScreen.route,
          //   );
          // }
          //      if (state is AuthErrorState) {
          //           showAuthErrorDailog(
          //             authError: state.authError,
          //             context: context,
          //           );
          //         }
        },
        child: Center(
            child: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onPressed: () async {
            context.read<AuthBloc>().add(
                  SignOutEvent(),
                );
          },
        )),
      ),
    );
  }
}
