import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racego/business_logic/login/login_bloc.dart';
import 'package:racego/ui/widgets/coloredbutton.dart';
import 'package:racego/ui/widgets/loggedoutdialog.dart';
import 'package:racego/generated/l10n.dart';
import 'package:racego/ui/widgets/ranking.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key, int? userId}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoggedOut || state is LoginError) {
          await loggedOutDialog(context);
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/');
          });
        }
      },
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  width: 800,
                  child: Ranking(
                    onAuthException: () =>
                        context.read<LoginBloc>().add(Logout()),
                  ),
                ),
              ),
            ),
            _bottomBar(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset('assets/racego_r.png', fit: BoxFit.cover),
      ),
      automaticallyImplyLeading: false,
      title: Text(
        S.current.ranking,
      ),
      centerTitle: true,
    );
  }

  Widget _bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColoredButton(
          Text(
            S.current.back,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.red,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
