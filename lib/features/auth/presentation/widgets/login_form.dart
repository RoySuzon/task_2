import 'package:flutter/material.dart';
import 'package:task/features/auth/data/repo/auth_repo_imp.dart';
import 'package:task/features/auth/domain/repo/auth_repo.dart';
import 'package:task/features/auth/domain/usecases/login_usercase.dart';
import 'package:task/features/dash_board/presentation/pages/dash_board_screen.dart';
import 'package:task/session_controller/session_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _login() async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        setState(() => isLoading = true);
      }
      final AuthRepo repo = AuthRepoImp(sessionManager: SecureStorageSession());
      LoginUserCase login = LoginUserCase(repo);
      // await Future.delayed(Duration(seconds: 2));
      final res = await login.loginExecute(context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (res) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()));
      }
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            SizedBox(height: 16),
            PasswordField(passwordController: _passwordController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(),
              child: Center(
                  child: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 1))
                      : Text('Login')),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._passwordController,
      decoration: InputDecoration(
          labelText: 'Password',
          suffix: IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() => obscureText = !obscureText);
                }
              },
              icon:
                  Icon(obscureText ? Icons.visibility : Icons.visibility_off))),
      obscureText: obscureText,
      validator: (value) =>
          value!.isEmpty ? 'Please enter your password' : null,
    );
  }
}
