import 'package:flutter/material.dart';

import '../database/workout_database.dart';
import '../feature_workout_list/workout_list_page.dart';
import '../util/localization_util.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splash";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WorkoutDatabase.instance.init().whenComplete(() => Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, WorkoutListPage.routeName, (route) => false);
      })),
      builder: (context, snapshot){
        return Scaffold(
          body: Center(
            child: Text(LocalizationUtil.localize(context).appTitle),
          ),
        );
      },
    );
  }
}
