import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/logic/blocs/auth/auth_bloc.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(
                SignInWithGoogleEvent(),
              );
        },
        icon: Image.asset(
          'assets/images/Google.svg.png',
          height: 20.h,
          width: 20.w,  
        ),
      ),
    );
  }
}
