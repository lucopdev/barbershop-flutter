import 'package:flutter/material.dart';
import 'package:barbearia_dos_brabos/_common/my_colors.dart';
import 'package:barbearia_dos_brabos/components/login_form_component.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.gradientTop, MyColors.gradientBottom],
              begin: FractionalOffset(0.0, 0.4), // 20% da largura do widget
              end: FractionalOffset(0.0, 0.9), // 80% da largura do wid
            ),
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
