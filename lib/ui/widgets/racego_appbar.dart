import 'package:flutter/material.dart';

class RacegoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RacegoAppBar({this.title = '', this.actions = const [], Key? key})
      : super(key: key);

  final String title;
  final List<Widget> actions;

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: Image.asset('assets/racego_r.png', fit: BoxFit.cover),
      ),
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }
}
