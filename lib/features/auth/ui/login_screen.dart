import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/app.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_cubit.dart';
import 'package:flutter_ecommerce_app/features/auth/logic/auth_states.dart';
import 'package:flutter_ecommerce_app/features/auth/ui/widgets/login_text_fields.dart';
import 'package:flutter_ecommerce_app/features/auth/ui/widgets/login_title_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBar(
              content: state.message ?? 'Success',
              state: SnackBarState.success,
            ),
          );
          context.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const App(),
              ),
                  (route) => false);
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBar(
              content: state.message ?? 'Error',
              state: SnackBarState.error,
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 112, bottom: 30),
              child: Column(
                children: [
                  Image.asset(
                    Assets.imageLogo,
                    height: 70,
                    width: 70,
                  ),
                  verticalSpace(16),
                  const LoginTitleText(),
                  verticalSpace(28),
                  const LoginTextFields(),
                  verticalSpace(16),
                  Container(
                    child: (state is LoginLoadingState)
                        ? const CircularProgressIndicator()
                        : AppButton(
                            onPressed: () {
                              if (context
                                  .read<AuthCubit>()
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                context.read<AuthCubit>().signIn();
                              }
                            },
                            text: 'Sign In',
                          ),
                  ),
                  verticalSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: AppStyles.bodyTextNormalBold,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushReplacementNamed(Routes.registerScreen);
                        },
                        child: Text(
                          'Register',
                          style: AppStyles.bodyTextNormalBold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
