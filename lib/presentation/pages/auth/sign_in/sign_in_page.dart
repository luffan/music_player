import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/presentation/di/locator.dart';
import 'package:music_player/presentation/model/app_pages.dart';
import 'package:music_player/presentation/pages/auth/sign_in/sign_in_state.dart';
import 'package:music_player/presentation/widget/app_button.dart';
import 'package:music_player/presentation/widget/app_text_field.dart';

import 'sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInCubit _cubit = locator<SignInCubit>();

  void _goToSignUpPage() {
    Navigator.of(context).pushNamed(
      AppPages.signUp.name,
    );
  }

  void _goToMainPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppPages.main.name,
      (_) => false,
    );
  }

  void _signIn() async {
    final currentState = _formKey.currentState;
    if (currentState != null && currentState.validate()) {
      currentState.save();
      await _cubit.signIn();
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
    return BlocListener<SignInCubit, SignInState>(
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
                  ..._buttonSection(context),
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
        'Sign in',
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

  List<Widget> _buttonSection(BuildContext context) {
    return [
      AppButton(
        text: 'Sign in',
        margin: 0,
        onTap: _signIn,
      ),
      const SizedBox(height: 24),
      const Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 24),
      AppButton(
        text: 'Profile',
        margin: 0,
        onTap: _goToSignUpPage,
      ),
    ];
  }
}
