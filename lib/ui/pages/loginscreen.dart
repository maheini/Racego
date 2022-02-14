import 'package:flutter/material.dart';

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
    return Scaffold(
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
                  } else if (password.isNotEmpty && _showPasswordEmptyMessage) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      print('hi');
                    },
                    child: Text('Anmelden'))
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
