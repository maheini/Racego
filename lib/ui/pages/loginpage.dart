import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/data/locator/locator.dart';
import 'package:racego/business_logic/blocs/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showEmailEmptyMessage = false;
  bool _showPasswordEmptyMessage = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginBloc>(),
      child: Scaffold(
          body: Center(
              child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        padding: const EdgeInsets.all(40),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Racego Login',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
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
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: (password) {
                    if (password.isEmpty && !_showPasswordEmptyMessage) {
                      setState(() {
                        _showPasswordEmptyMessage = true;
                      });
                    } else if (password.isNotEmpty &&
                        _showPasswordEmptyMessage) {
                      setState(() {
                        _showPasswordEmptyMessage = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText:
                        _showPasswordEmptyMessage ? 'Passwort ist leer' : null,
                    border: const OutlineInputBorder(),
                    hintText: 'Passwort',
                    labelText: 'Passwort',
                  )),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoggedOut) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              locator.get<LoginBloc>().add(Login(
                                  _emailController.text,
                                  _passwordController.text));
                            },
                            child: const Text('Anmelden'))
                      ],
                    );
                  } else if (state is Loading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        ElevatedButton(onPressed: null, child: Text('Melde an'))
                      ],
                    );
                  } else if (state is LoggedIn) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/');
                    });
                    return const Text('Anmelden erfolgreich');
                  } else {
                    return const Text('Unbekannter Fehler');
                  }
                },
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
