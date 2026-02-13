import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olearis_tech_task/repositories/auth/auth_repository.dart';
import 'package:olearis_tech_task/styles/app_colors.dart';
import 'package:olearis_tech_task/views/home/home_view.dart';

import 'sign_in_cubit.dart';
import 'sign_in_state.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
      child: const _SignInBody(),
    );
  }
}

class _SignInBody extends StatelessWidget {
  const _SignInBody();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const HomeView()),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: constraints.maxHeight * 0.18,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            width: 360,
                          ),
                        ),
                        Column(
                          children: [
                            TextField(
                              onChanged: (value) => context
                                  .read<SignInCubit>()
                                  .updateLogin(value),
                              decoration: InputDecoration(
                                hintText: 'Login',
                                hintStyle:
                                    TextStyle(color: colors.textSecondary),
                              ),
                            ),
                            TextField(
                              onChanged: (value) => context
                                  .read<SignInCubit>()
                                  .updatePassword(value),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle:
                                    TextStyle(color: colors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 24, bottom: 20),
                          child: BlocBuilder<SignInCubit, SignInState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state.isValid && !state.isLoading
                                    ? () =>
                                        context.read<SignInCubit>().signIn()
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors.appBar,
                                  disabledBackgroundColor: state.isLoading
                                      ? colors.appBar
                                      : colors.textSecondary
                                          .withValues(alpha: 0.3),
                                  foregroundColor: Colors.white,
                                  disabledForegroundColor:
                                      colors.textSecondary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: state.isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Continue'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
