import 'package:apple_shop/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:apple_shop/common/constants/colors.dart';
import 'package:apple_shop/features/auth/presentation/widgets/login/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: CustomColors.blue,
          body: LoginBody(),
        ),
      ),
    );
  }
}
