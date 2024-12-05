import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/config/app_config.dart';
import 'package:hacker_news/data/providers/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Login'),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kContentPadding),
      child: Center(child: _loginElements),
    ),
  );

  Widget get _loginElements => ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 300,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailTextField,
        const SizedBox(height: 8,),
        _passwordTextField,
        const SizedBox(height: 8,),
        _loginButton,
      ],
    ),
  );

  Widget get _emailTextField => TextField(
    controller: _emailController,
    autofocus: true,
    keyboardType: TextInputType.emailAddress,
    autofillHints: [AutofillHints.email],
    autocorrect: true,
    decoration: InputDecoration(
      hintText: 'E-Mail',
      border: OutlineInputBorder(),
    ),
  );

  Widget get _passwordTextField => TextField(
    controller: _passwordController,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      border: OutlineInputBorder(),
    ),
  );

  Widget get _loginButton => TextButton(
    onPressed: _onLoginPressed, 
    child: Text('Login'),
  );

  Future<void> _onLoginPressed() async {
    await ref.read(appwriteAccountProvider).createEmailPasswordSession(
      email: _emailController.text, 
      password: _passwordController.text,
    );
  }
}