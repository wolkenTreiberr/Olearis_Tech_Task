import 'package:flutter/material.dart';
import 'package:olearis_tech_task/app/app_provider.dart';
import 'package:olearis_tech_task/styles/app_theme.dart';
import 'package:olearis_tech_task/views/sign_in/sign_in_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Olearis Tech Task',
        theme: buildAppTheme(),
        debugShowCheckedModeBanner: false,
        home: const SignInView(),
      ),
    );
  }
}
