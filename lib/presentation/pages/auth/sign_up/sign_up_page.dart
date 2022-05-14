import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/model/app_pages.dart';
import 'package:music_player/presentation/pages/auth/sign_up/sign_up_state.dart';
import 'package:music_player/presentation/widget/app_button.dart';
import 'package:music_player/presentation/widget/app_text_field.dart';

import 'sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpCubit _cubit = locator<SignUpCubit>();

  void _goToMainPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppPages.main.name,
      (_) => false,
    );
  }

  void _register() async {
    final currentState = _formKey.currentState;
    if (currentState != null && currentState.validate()) {
      currentState.save();
      await _cubit.signUp();
    }
  }

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      bloc: _cubit,
      listener: (context, state) => _goToMainPage(),
      listenWhen: (prev, cur) => prev.completed != cur.completed,
      child: Scaffold(
        backgroundColor: const Color(0xFF253334),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  ..._labelSection(),
                  const SizedBox(height: 112),
                  ..._formFieldsSection(),
                  const SizedBox(height: 56),
                  ..._buttonSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _labelSection() {
    return [
      const Text(
        'Sign up',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    ];
  }

  List<Widget> _formFieldsSection() {
    return [
      AppTextField(
        hintText: 'Name',
        onSaved: _cubit.updateName,
      ),
      const SizedBox(height: 40),
      AppTextField(
        hintText: 'Email',
        onSaved: _cubit.updateEmail,
      ),
      const SizedBox(height: 40),
      AppTextField(
        hintText: 'Password',
        obscureText: true,
        onSaved: _cubit.updatePassword,
      ),
    ];
  }

  List<Widget> _buttonSection() {
    return [
      AppButton(
        text: 'Register',
        margin: 0,
        onTap: _register,
      ),
    ];
  }
}
