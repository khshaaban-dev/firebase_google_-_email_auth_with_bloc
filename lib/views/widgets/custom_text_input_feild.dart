import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tiktok_clone/constants/constants.dart';

typedef Validate = String? Function(String? vlaue);

class CustomTextInputFormFeild extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool? isObscure;
  final Validate validate;
  const CustomTextInputFormFeild({
    Key? key,
    required this.validate,
    required this.labelText,
    required this.icon,
    required this.controller,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: controller,
      obscureText: isObscure!,
      obscuringCharacter: '0',
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(
          fontSize: 16.sp,
        ),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.w),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.w),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.w),
          borderSide: BorderSide(
            color: errorBorderColor,
          ),
        ),
      ),
    );
  }
}
