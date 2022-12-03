import 'package:flutter/material.dart';

class ParameterSlider extends StatefulWidget {

  const ParameterSlider(
      this.label, this.updateFunction,
      {this.value, Key? key})
      : super(key: key);

  final String label;
  final Function updateFunction;
  final double? value;

  @override
  State<ParameterSlider> createState() => _ParameterSliderState();
}

class _ParameterSliderState extends State<ParameterSlider> {

  @override
  Widget build(BuildContext context) {
    double equalizationValue = widget.value ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.headline6,
        ),
        Slider(
          value: equalizationValue,
          max: 10.0,
          divisions: 10,
          label: equalizationValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              equalizationValue = value;
            });
            widget.updateFunction(value);
          },
        )
      ],
    );
  }
}
