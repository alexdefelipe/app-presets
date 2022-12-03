import 'dart:math';

import 'package:flutter/material.dart';

class EqualizationSpinner extends StatefulWidget {
  const EqualizationSpinner(this.label, this.value, this._controller,
      {Key? key})
      : super(key: key);

  final String label;
  final double value;
  final AnimationController _controller;

  @override
  State<EqualizationSpinner> createState() => _EqualizationSpinnerState();
}

class _EqualizationSpinnerState extends State<EqualizationSpinner> {
  late Animation<double> valueTween;

  @override
  Widget build(BuildContext context) {
    valueTween = Tween<double>(begin: 0, end: widget.value).animate(widget._controller)
      ..addListener(() {
        setState(() {});
      });

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Transform.rotate(
                  angle: -pi * 3 / 4,
                  child: CircularProgressIndicator(
                    value: valueTween.value / (40 / 3),
                    backgroundColor: Colors.white,
                  ),
                ),
                Center(
                  child: Text(widget.value.round().toString()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }
}
