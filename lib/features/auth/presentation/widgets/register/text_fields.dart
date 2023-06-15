import 'package:apple_shop/features/auth/presentation/bloc/auth_state.dart';
import 'package:apple_shop/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/colors.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class RegisterTextFields extends StatelessWidget {
  RegisterTextFields({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RegisterTextField(
            controller: _usernameTextController, labelText: 'نام کاربری'),
        SizedBox(
          height: 20.h,
        ),
        RegisterTextField(
            controller: _passwordTextController, labelText: 'رمز عبور'),
        SizedBox(
          height: 20.h,
        ),
        RegisterTextField(
            controller: _confirmPasswordController,
            labelText: 'تایید رمز عبور'),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitState) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontFamily: 'SB', fontSize: 18.sp),
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    )),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthRegisterRequest(
                      _usernameTextController.text,
                      _passwordTextController.text,
                      _confirmPasswordController.text,
                    ),
                  );
                },
                child: const Text('ثبت نام'),
              );
            }

            if (state is AuthLoadingState) {
              return const CircularProgressIndicator();
            }

            if (state is AuthResponseState) {
              Text widget = const Text('');

              state.response.fold((l) {
                widget = Text(l);
              }, (r) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BaseScreen(),
                    ),
                  );
                });

                widget = Text(r);
              });

              return widget;
            }

            return const Text('خطای نامشخص');
          },
        )
      ],
    );
  }
}

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const RegisterTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'SM',
          fontSize: 18.sp,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: Colors.black, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: CustomColors.blue, width: 3),
        ),
      ),
    );
  }
}
