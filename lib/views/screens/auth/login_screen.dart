import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/logic/blocs/auth/auth_bloc.dart';
import 'package:tiktok_clone/views/dialogs/show_auth_error.dart';
import 'package:tiktok_clone/views/loading/loading_screen.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/screens/screens.dart';
import 'package:tiktok_clone/views/widgets/widgets.dart'
    show CustomTextInputFormFeild, GoogleSignInButton;

class LoginScreen extends StatelessWidget {
  static const String route = '/loginScreen';
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController =
      TextEditingController(text: 'hbmohamed89@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'kh01063442598');
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        //      if (state is AuthErrorState) {
        //             showAuthErrorDailog(
        //               authError: state.authError,
        //               context: context,
        //             );
        //           }
        // if (state is AuthanticatedState) {
        //   Navigator.pushReplacementNamed(
        //     context,
        //     HomeScreen.route,
        //   );
        // }
      },
      child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tiktok clone',
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: CustomTextInputFormFeild(
                      validate: (value) {
                        if (value!.isEmpty) return 'Filed Is Empty';
                        return null;
                      },
                      labelText: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: CustomTextInputFormFeild(
                      validate: (value) {
                        if (value!.isEmpty) return 'Filed Is Empty';
                        return null;
                      },
                      labelText: 'Password',
                      icon: Icons.lock,
                      controller: passwordController,
                      isObscure: true,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      final state = globalKey.currentState!.validate();
                      if (state) {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                email: email,
                                password: password,
                              ),
                            );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      alignment: Alignment.center,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(
                          12.h,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const GoogleSignInButton(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  GoToSignUpScreenEvent(),
                                );
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: buttonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    ));
  }
}
