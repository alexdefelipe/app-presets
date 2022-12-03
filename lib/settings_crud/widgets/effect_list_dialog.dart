import 'package:flutter/material.dart';

import '../../persistance/models/effect.dart';

class EffectListDialog extends StatefulWidget {
  const EffectListDialog(
      {required this.effects,
      required this.selectedEffect,
      required this.onSelectedEffect,
      Key? key})
      : super(key: key);

  final List<Effect> effects;
  final Function onSelectedEffect;
  final Effect selectedEffect;

  @override
  State<EffectListDialog> createState() => _EffectListDialogState();
}

class _EffectListDialogState extends State<EffectListDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.effects.length,
          itemBuilder: (BuildContext context, int index) {
            Effect effect = widget.effects[index];
            return ListTile(
              title: Text(effect.name),
              leading: Icon(
                widget.selectedEffect.id == effect.id
                    ? Icons.fiber_manual_record
                    : Icons.fiber_manual_record_outlined,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => widget.onSelectedEffect(effect),
            );
          },
        ),
      ),
    );
  }
}
