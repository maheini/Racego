import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is RegeneratingSession) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoggedIn) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
            return const SizedBox(height: 20);
          } else {
            return Container(
              child: SizedBox(
                child: Column(
                  children: [
                    const Text(
                      'Racego Login',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _emailInput(),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordInput(),
                    const SizedBox(
                      height: 20,
                    ),
                    _loginBar(),
                  ],
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                width: 300,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              padding: const EdgeInsets.all(40),
            );
          }
        }),
      ),
    );
  }

  // Password input field
  bool _showEmailEmptyMessage = false;
  final TextEditingController _emailController = TextEditingController();
  Widget _emailInput() {
    return TextField(
      onSubmitted: (_) {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          context
              .read<LoginBloc>()
              .add(Login(_emailController.text, _passwordController.text));
        }
      },
      controller: _emailController,
      onChanged: (email) {
        if (email.isEmpty && !_showEmailEmptyMessage) {
          setState(() {
            _showEmailEmptyMessage = true;
          });
        } else if (email.isNotEmpty && _showEmailEmptyMessage) {
          setState(() {
            _showEmailEmptyMessage = false;
          });
        }
      },
      decoration: InputDecoration(
        errorText: _showEmailEmptyMessage ? 'Email ist leer' : null,
        border: const OutlineInputBorder(),
        hintText: 'Email',
        labelText: 'Email',
      ),
    );
  }

  // Email input field
  bool _showPasswordEmptyMessage = false;
  final TextEditingController _passwordController = TextEditingController();
  Widget _passwordInput() {
    return TextField(
      onSubmitted: (_) {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          context
              .read<LoginBloc>()
              .add(Login(_emailController.text, _passwordController.text));
        }
      },
      obscureText: true,
      controller: _passwordController,
      onChanged: (password) {
        if (password.isEmpty && !_showPasswordEmptyMessage) {
          setState(() {
            _showPasswordEmptyMessage = true;
          });
        } else if (password.isNotEmpty && _showPasswordEmptyMessage) {
          setState(() {
            _showPasswordEmptyMessage = false;
          });
        }
      },
      decoration: InputDecoration(
        errorText: _showPasswordEmptyMessage ? 'Passwort ist leer' : null,
        border: const OutlineInputBorder(),
        hintText: 'Passwort',
        labelText: 'Passwort',
      ),
    );
  }

  // Login top bar (loginbutton and bloc integration)
  Widget _loginBar() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoggedOut || state is RegeneratingSession) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: ColoredButton(
                  const Text(
                    'Anmelden',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    context.read<LoginBloc>().add(
                        Login(_emailController.text, _passwordController.text));
                  },
                ),
              ),
            ],
          );
        } else if (state is Loading) {
          return const CircularProgressIndicator();
        } else if (state is LoginError) {
          return Column(
            children: [
              Text(
                state.errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ColoredButton(
                    const Text(
                      'Anmelden',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      context.read<LoginBloc>().add(Login(
                          _emailController.text, _passwordController.text));
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('Unbekannter Fehler');
        }
      },
    );
  }
}
