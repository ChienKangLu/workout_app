import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/custom_dialog.dart';
import '../../core_view/list_item.dart';
import '../exercise_info_view_model.dart';

class ExerciseInfoDialog extends StatefulWidget {
  const ExerciseInfoDialog({
    Key? key,
    required this.exerciseId,
  }) : super(key: key);

  final int exerciseId;

  @override
  State<ExerciseInfoDialog> createState() => _ExerciseInfoDialogState();
}

class _ExerciseInfoDialogState extends State<ExerciseInfoDialog> {
  late final ExerciseInfoViewModel _model;

  int get _exerciseId => widget.exerciseId;

  @override
  void initState() {
    _model = ExerciseInfoViewModel(exerciseId: _exerciseId);

    initViewModels();

    super.initState();
  }

  Future<void> initViewModels() async {
    await _model.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _model),
        ],
        child: Consumer<ExerciseInfoViewModel>(
          builder: (context, viewModel, child) {
            final exerciseInfoUiState = viewModel.exerciseInfoUiState;

            return exerciseInfoUiState.run(
              onLoading: () => const SizedBox(),
              onSuccess: (success) {
                final exerciseInfo = success.exerciseInfo;
                return CustomDialog(
                  title: "Info - ${exerciseInfo.name}",
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListItem(
                        text: "Max: ${exerciseInfo.max} kg",
                      ),
                      // const ListItem(
                      //   text: "",
                      // ),
                    ],
                  ),
                );
              },
              onError: () {
                return CustomDialog(
                  title: "No statistic",
                  child: SizedBox(),
                );
              },
            );
          },
        ));
  }
}
