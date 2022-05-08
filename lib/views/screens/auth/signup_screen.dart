import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/constants/constants.dart';
import 'package:tiktok_clone/logic/blocs/auth/auth_bloc.dart';
import 'package:tiktok_clone/logic/utils/pick_profile_image.dart';
import 'package:tiktok_clone/views/dialogs/show_auth_error.dart';
import 'package:tiktok_clone/views/loading/loading_screen.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/screens.dart';
import 'package:tiktok_clone/views/widgets/widgets.dart'
    show CustomTextInputFormFeild, GoogleSignInButton;

class SignUpScreen extends StatefulWidget {
  static const String route = '/SignUpScreen';
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  late File? file;
  bool imageLoaded = false;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ImageProvider _getImage() {
    if (imageLoaded) {
      return FileImage(file!);
    } else {
      return const AssetImage('assets/images/person.png');
    }
  }

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

        // if (state is AuthErrorState) {
        //   showAuthErrorDailog(
        //     authError: state.authError,
        //     context: context,
        //   );
        // }
        // if (state is AuthanticatedState) {
        //   Navigator.pushReplacementNamed(
        //     context,
        //     HomeScreen.route,
        //   );
        // }
        // if (state is AuthErrorState) {
        //   showAuthErrorDailog(
        //     authError: state.authError,
        //     context: context,
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
                    'SingUp',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.h,
                        backgroundColor: Colors.grey,
                        backgroundImage: _getImage(),
                      ),
                      Positioned(
                          bottom: -15,
                          right: 0,
                          child: IconButton(
                            onPressed: () async {
                              final image = await pickProfileImage();
                              if (image != null) {
                                file = File(image);
                                setState(() {
                                  imageLoaded = true;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ))
                    ],
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
                      labelText: 'User Name',
                      icon: Icons.email,
                      controller: nameController,
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
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      //globalKey.currentState!.validate();
                      final state = globalKey.currentState!.validate();
                      if (state && file!.path.isNotEmpty) {
                        final email = emailController.text;
                        final password = passwordController.text;
                        // final name = nameController.text;

                        context.read<AuthBloc>().add(
                              SignUpEvent(
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
                        'Register',
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
                          'Already have an account ?',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  GoToSignInScreenEvent(),
                                );
                          },
                          child: Text(
                            ' Login',
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
