import 'package:apple_shop/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/colors.dart';
import '../../../../../screens/base_screen.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class LoginTextFields extends StatelessWidget {
   LoginTextFields({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: _usernameTextController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'نام کاربری',
            labelStyle: TextStyle(
              fontFamily: 'SM',
              fontSize: 18.sp,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide:
              const BorderSide(color: Colors.black, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                  color: CustomColors.blue, width: 3),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextField(
          controller: _passwordTextController,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            labelText: 'رمز عبور',
            labelStyle: TextStyle(
              fontFamily: 'SM',
              fontSize: 18.sp,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide:
              const BorderSide(color: Colors.black, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                  color: CustomColors.blue, width: 3),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitState) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        fontFamily: 'SB', fontSize: 18.sp),
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    )),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthLoginRequest(
                      _usernameTextController.text,
                      _passwordTextController.text,
                    ),
                  );
                },
                child: const Text('ورود'),
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
