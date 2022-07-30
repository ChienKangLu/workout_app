import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'view/workout_list.dart';
import 'view/workout_list_page_bottom_bar.dart';
import 'workout_list_view_model.dart';

class WorkoutListPage extends StatefulWidget {
  static const routeName = "/workout_list";

  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {

  late WorkoutListViewModel _model;

  @override
  void initState() {
    _model = WorkoutListViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
      ),
      body: WorkoutList(
        workoutListState: _model.workoutListState,
      ),
      bottomNavigationBar: WorkoutListPageBottomBar(
        onAddItemClicked: () {
          // TODO: choose type of workout then create a new workout
        },
      ),
    );
  }
}