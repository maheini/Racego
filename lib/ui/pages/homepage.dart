import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/data/models/user.dart';
import 'package:racego/ui/widgets/user_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _forcedLogout = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: ((context, state) async {
        if (state is LoggedOut || state is LoginError) {
          if (_forcedLogout) {
            Navigator.pushReplacementNamed(context, '/');
          } else {
            await _loggedOutDialog();
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
          }
        }
      }),
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset('assets/racego_r.png', fit: BoxFit.cover),
      ),
      backgroundColor: const Color.fromARGB(255, 175, 0, 6),
      title: const Text(
        'Racego',
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
          ),
          onPressed: () async {
            _forcedLogout = true;
            context.read<LoginBloc>().add(Logout());
          },
        )
      ],
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          const TimeInput(),
          const SizedBox(height: 30),
          const Text(
            'Willkommen zurück',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 20),
                Expanded(child: _userList()),
                const SizedBox(width: 30),
                Expanded(child: _trackList()),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // _userToolBar(),
        ],
      ),
    );
  }

  Widget _userList() {
    return Column(
      children: [
        Expanded(
          child: UserList(
            gg2on ? gg2 : gg,
            title: 'Teilnehmer',
          ),
        ),
        Row(
          children: [
            _toolButton(const Icon(Icons.info)),
            _toolButton(const Icon(Icons.remove_circle)),
            _toolButton(const Icon(Icons.assistant_photo)),
          ],
        ),
      ],
    );
  }

  Widget _trackList() {
    return Column(
      children: [
        Expanded(
          child: UserList(
            gg,
            title: 'Rennstrecke',
          ),
        ),
        Row(
          children: [
            _toolButton(const Icon(Icons.info)),
            _toolButton(const Icon(Icons.remove_circle)),
          ],
        ),
      ],
    );
  }

  Widget _toolButton(Icon icon, {VoidCallback? onpressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
          ),
          onPressed: onpressed,
          child: icon,
        ),
      ),
    );
  }

  List<User> listt = [];

  bool gg2on = false;

  final List<User> gg2 = [
    User(0, 'dsfgdsfg', 'Heini', 3),
    User(1, 'Müdsfgdfsgdsfgdsfgdsfgller', 'Markus', 5),
    User(2, 'dfsgdsfgdsf', 'Heini', 3),
    User(3, 'dsfgdsfgdfsg', 'Markus', 5),
    User(4, 'fgsdfgdsfg', 'Heini', 3),
    User(5, 'dfgdfgdsfgd', 'Markus', 5),
    User(6, 'dsfdsfdfgdfsg', 'Heini', 3),
    User(7, 'dsfgdfsgdfsg', 'Markus', 5),
  ];

  final List<User> gg = [
    User(6, 'Martin', 'Heini', 3),
    User(7, 'Müller', 'Markus', 5),
    User(8, 'fgdfgdgf', 'Heini', 3),
    User(9, 'Müller', 'Markus', 5),
    User(10, 'dfsgdfsgdfsg', 'Heini', 3),
    User(11, 'Müller', 'Markus', 5),
    User(12, 'dfgdsfgdfsg', 'Heini', 3),
    User(13, 'Müller', 'Markus', 5),
    User(14, 'dfsgdsfgdfsg', 'Heini', 3),
    User(15, 'Müller', 'Markus', 5),
    User(16, 'dfsgdfsgdfsg', 'Heini', 3),
    User(17, 'Müller', 'Markus', 5),
    User(18, 'dsfgdsfgdfg', 'Heini', 3),
    User(19, 'Müller', 'Markus', 5),
    User(20, 'dsfkhdshdgfs', 'Heini', 3),
    User(21, 'Müller', 'Markus', 5),
    User(22, 'Peter', 'Heini', 3),
    User(23, 'Müller', 'Markus', 5),
    User(24, 'Marlies', 'Heini', 3),
    User(25, 'Müller', 'Markus', 5),
  ];

  Future<void> _loggedOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sitzung abgelaufen'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Ihre Sitzung ist abgelaufen. Bitte melden Sie sich neu an.')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anmelden'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class TimeInput extends StatelessWidget {
  const TimeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          TextField(
            keyboardType: TextInputType.datetime,
          )
        ],
      ),
    );
    return Container(
      constraints: BoxConstraints.tight(Size.square(50)),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          TextField(
            keyboardType: TextInputType.datetime,
          )
        ],
      ),
    );
  }
}
