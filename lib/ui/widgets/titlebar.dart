import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(this.title, {this.subtitle, this.fontSize = 20, Key? key})
      : super(key: key);

  final String title;
  final String? subtitle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) const SizedBox(height: 5),
          if (subtitle != null)
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
