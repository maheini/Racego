import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isRegistration = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is RegeneratingSession) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoggedIn) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/');
              });
              return const SizedBox(height: 20);
            } else {
              return Container(
                child: SizedBox(
                  child: Column(
                    children: [
                      Text(
                        _isRegistration
                            ? S.current.register_title
                            : S.current.sign_in_title,
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      _usernameInput(),
                      const SizedBox(
                        height: 20,
                      ),
                      _passwordInput(),
                      const SizedBox(
                        height: 10,
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
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              );
            }
          },
        ),
      ),
    );
  }

  // Password input field
  bool _showUsernameEmptyMessage = false;
  final TextEditingController _usernameController = TextEditingController();
  Widget _usernameInput() {
    return TextField(
      onSubmitted: (_) {
        if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          context
              .read<LoginBloc>()
              .add(Login(_usernameController.text, _passwordController.text));
        }
      },
      controller: _usernameController,
      onChanged: (username) {
        if (username.isEmpty && !_showUsernameEmptyMessage) {
          setState(() {
            _showUsernameEmptyMessage = true;
          });
        } else if (username.isNotEmpty && _showUsernameEmptyMessage) {
          setState(() {
            _showUsernameEmptyMessage = false;
          });
        }
      },
      decoration: InputDecoration(
        errorText: _showUsernameEmptyMessage ? S.current.username_empty : null,
        border: const OutlineInputBorder(),
        hintText: S.current.username,
        labelText: S.current.username,
        labelStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText2?.color ?? Colors.black,
        ),
      ),
    );
  }

  // Username input field
  bool _showPasswordEmptyMessage = false;
  final TextEditingController _passwordController = TextEditingController();
  Widget _passwordInput() {
    return TextField(
      onSubmitted: (_) {
        if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          context
              .read<LoginBloc>()
              .add(Login(_usernameController.text, _passwordController.text));
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
        errorText: _showPasswordEmptyMessage ? S.current.password_empty : null,
        border: const OutlineInputBorder(),
        hintText: S.current.password,
        labelText: S.current.password,
        labelStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText2?.color ?? Colors.black,
        ),
      ),
    );
  }

  // Login top bar (loginbutton and bloc integration)
  Widget _loginBar() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoggedOut ||
            state is RegeneratingSession ||
            state is LoginError) {
          if (state is LoggedOut) {
            if (_isRegistration != state.registerPage) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _isRegistration = state.registerPage;
                });
              });
            }
          }
          return Column(
            children: [
              if (state is LoginError)
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
                  SizedBox(
                    child: ColoredButton(
                      Text(
                        _isRegistration
                            ? S.current.register
                            : S.current.sign_in,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        if (_isRegistration) {
                          context.read<LoginBloc>().add(Register(
                              _usernameController.text,
                              _passwordController.text));
                        } else {
                          context.read<LoginBloc>().add(Login(
                              _usernameController.text,
                              _passwordController.text));
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (_isRegistration) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<LoginBloc>()
                          .add(SwitchLogin(register: false));
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<LoginBloc>()
                          .add(SwitchLogin(register: true));
                    });
                  }
                },
                child: Text(
                  _isRegistration
                      ? S.current.login_now
                      : S.current.register_now,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
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
                    Text(
                      S.current.sign_in,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      context.read<LoginBloc>().add(Login(
                          _usernameController.text, _passwordController.text));
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return Text(S.current.unknown_error);
        }
      },
    );
  }
}
