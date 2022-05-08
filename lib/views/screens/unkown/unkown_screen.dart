import 'package:flutter/material.dart';

class UnkownScreen extends StatelessWidget {
  static const String route = '/unkownScreen';
  const UnkownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('unkown route try restart app '),
      ),
    );
  }
}
