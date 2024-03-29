import 'package:flutter/material.dart';

import '../../core_view/util/display_string_util.dart';
import '../../model/unit.dart';
import '../../util/localization_util.dart';
import '../../util/weight_unit_convertor.dart';

abstract class EditSetData {}

class CreateOrUpdateSetData extends EditSetData {
  CreateOrUpdateSetData(
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

class RemoveSetData extends EditSetData {}

class EditSetSheet extends StatefulWidget {
  const EditSetSheet({
    Key? key,
    required this.title,
    this.removeAllowed = false,
    this.repetition,
    this.baseWeight,
    this.sideWeight,
  }) : super(key: key);

  final String title;
  final bool removeAllowed;
  final int? repetition;
  final double? baseWeight;
  final double? sideWeight;

  @override
  State<EditSetSheet> createState() => _EditSetSheetState();
}

class _EditSetSheetState extends State<EditSetSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _repetitionController;
  late final TextEditingController _baseWeightController;
  late final TextEditingController _sideWeightController;

  final _weightUnits = [WeightUnit.kilogram, WeightUnit.pound];
  WeightUnit _baseWeightUnit = WeightUnit.kilogram;
  WeightUnit _sideWeightUnit = WeightUnit.kilogram;

  String get _title => widget.title;
  bool get _allowRemove => widget.removeAllowed;
  int? get _repetition => widget.repetition;
  double? get _baseWeight => widget.baseWeight;
  double? get _sideWeight => widget.sideWeight;

  @override
  void initState() {
    _repetitionController =
        TextEditingController(text: _repetition?.toString());
    _baseWeightController =
        TextEditingController(text: _baseWeight?.toString());
    _sideWeightController =
        TextEditingController(text: _sideWeight?.toString());

    super.initState();
  }

  @override
  void dispose() {
    _repetitionController.dispose();
    _baseWeightController.dispose();
    _sideWeightController.dispose();

    super.dispose();
  }

  void _onSaveButtonClicked() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final repetition = int.parse(_repetitionController.text);
    final baseWeight = double.parse(_baseWeightController.text);
    final sideWeight = double.parse(_sideWeightController.text);

    Navigator.pop(
      context,
      CreateOrUpdateSetData(
        repetition,
        baseWeight,
        sideWeight,
        _baseWeightUnit,
        _sideWeightUnit,
      ),
    );
  }

  void _onRemoveButtonClicked() {
    Navigator.pop(
      context,
      RemoveSetData(),
    );
  }

  void _onUnitButtonClicked(
    TextEditingController controller,
    WeightUnit unit,
    WeightUnit newUnit,
    void Function(WeightUnit newUnit) updateUnit,
  ) {
    if (unit == newUnit) {
      return;
    }

    setState(() {
      updateUnit(newUnit);
    });

    if (_allowRemove) {
      _convertWeightByUnit(controller, newUnit);
    }
  }

  void _convertWeightByUnit(
    TextEditingController controller,
    WeightUnit unit,
  ) {
    final text = controller.text;
    final weight = double.tryParse(text);
    if (weight == null) {
      return;
    }

    final convertedWeight = WeightUnitConvertor.convert(
      weight,
      unit == WeightUnit.kilogram ? WeightUnit.pound : WeightUnit.kilogram,
      to: unit == WeightUnit.kilogram ? WeightUnit.kilogram : WeightUnit.pound,
    );

    controller.text = convertedWeight.toString();
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
              _title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (_allowRemove)
            TextButton(
              onPressed: _onRemoveButtonClicked,
              child: Text(
                  LocalizationUtil.localize(context).removeExerciseSetTitle),
            ),
          TextButton(
            onPressed: _onSaveButtonClicked,
            child:
                Text(LocalizationUtil.localize(context).saveExerciseSetTitle),
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
      unit: _baseWeightUnit,
      onPressed: (index) {
        _onUnitButtonClicked(
          _baseWeightController,
          _baseWeightUnit,
          _weightUnits[index],
          (newUnit) {
            _baseWeightUnit = newUnit;
          },
        );
      },
    );
  }

  Widget _sideWeightItem() {
    return _weightTextFormField(
      controller: _sideWeightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      labelText: LocalizationUtil.localize(context).sideWeightTitle,
      unit: _sideWeightUnit,
      onPressed: (index) {
        _onUnitButtonClicked(
          _sideWeightController,
          _sideWeightUnit,
          _weightUnits[index],
          (newUnit) {
            _sideWeightUnit = newUnit;
          },
        );
      },
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
            _weightUnits[0].unitString(context),
          ),
          Text(
            _weightUnits[1].unitString(context),
          ),
        ],
      ),
    );
  }
}
