import 'package:flutter/material.dart';
import 'package:music_player/presentation/utils/validators.dart';

typedef Validator = String? Function(String?);
typedef OnSaved = void Function(String?);

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Validator? validator;
  final OnSaved? onSaved;

  const AppTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.validator = AppValidators.usualValidator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText,
      style: const TextStyle(
        color: Color(0xFFBEC2C2),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        focusColor: const Color(0xFFBEC2C2),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFBEC2C2),
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }
}
