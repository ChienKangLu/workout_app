import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
      ),
      body: const Center(
        child: Text('Let\'s workout'),
      ),
    );
  }
}
