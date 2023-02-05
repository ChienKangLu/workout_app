import 'package:flutter/material.dart';

import '../../core_view/util/weight_unit_display_helper.dart';
import '../../model/unit.dart';
import '../../util/localization_util.dart';

class AddSetData {
  AddSetData(
    this.repetition,
    this.baseWeight,
    this.sideWeight,
    this.baseWeightUnit,
    this.sideWeightUnit,
  );

  final int repetition;
  final double baseWeight;
  final double sideWeight;
  final WeightUnit baseWeightUnit;
  final WeightUnit sideWeightUnit;
}

class AddSetSheet extends StatefulWidget {
  const AddSetSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSetSheet> createState() => _AddSetSheetState();
}

class _AddSetSheetState extends State<AddSetSheet> {
  final _formKey = GlobalKey<FormState>();
  final _repetitionController = TextEditingController();
  final _baseWeightController = TextEditingController();
  final _sideWeightController = TextEditingController();

  final weightUnits = [WeightUnit.kilogram, WeightUnit.pound];
  WeightUnit baseWeightUnit = WeightUnit.kilogram;
  WeightUnit sideWeightUnit = WeightUnit.kilogram;

  void _onSaveButtonClicked() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final repetition = int.parse(_repetitionController.text);
    final baseWeight = double.parse(_baseWeightController.text);
    final sideWeight = double.parse(_sideWeightController.text);

    Navigator.pop(
      context,
      AddSetData(
        repetition,
        baseWeight,
        sideWeight,
        baseWeightUnit,
        sideWeightUnit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, viewInsets.top, 24, viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _repetitionItem(),
                  const SizedBox(height: 15),
                  _baseWeightItem(),
                  const SizedBox(height: 15),
                  _sideWeightItem(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 64),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Add set - Squat",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TextButton(
            onPressed: _onSaveButtonClicked,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _repetitionItem() {
    return SizedBox(
      width: 100,
      child: _textFormField(
        controller: _repetitionController,
        keyboardType: TextInputType.number,
        labelText: LocalizationUtil.localize(context).repetitionTitle,
      ),
    );
  }

  Widget _baseWeightItem() {
    return _weightTextFormField(
      controller: _baseWeightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      labelText: LocalizationUtil.localize(context).baseWeightTitle,
      unit: baseWeightUnit,
      onPressed: (index) => setState(() {
        baseWeightUnit = weightUnits[index];
      }),
    );
  }

  Widget _sideWeightItem() {
    return _weightTextFormField(
      controller: _sideWeightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      labelText: LocalizationUtil.localize(context).sideWeightTitle,
      unit: sideWeightUnit,
      onPressed: (index) => setState(() {
        sideWeightUnit = weightUnits[index];
      }),
    );
  }

  Widget _weightTextFormField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String labelText,
    required WeightUnit unit,
    required void Function(int) onPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: _textFormField(
            controller: controller,
            keyboardType: keyboardType,
            labelText: labelText,
          ),
        ),
        const SizedBox(width: 10),
        _toggleButton(
          unit,
          onPressed,
        ),
      ],
    );
  }

  Widget _textFormField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String labelText,
  }) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          errorStyle: const TextStyle(
            height: 0,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "";
          }
          return null;
        },
      ),
    );
  }

  Widget _toggleButton(
    WeightUnit unit,
    void Function(int) onPressed,
  ) {
    return SizedBox(
      height: 48,
      child: ToggleButtons(
        isSelected: [
          unit == WeightUnit.kilogram,
          unit == WeightUnit.pound,
        ],
        onPressed: onPressed,
        children: [
          Text(
            WeightUnitDisplayHelper.toDisplayString(context, weightUnits[0]),
          ),
          Text(
            WeightUnitDisplayHelper.toDisplayString(context, weightUnits[1]),
          ),
        ],
      ),
    );
  }
}
