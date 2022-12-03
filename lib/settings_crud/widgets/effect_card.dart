import 'package:amp_presets/persistance/services/effect_service.dart';
import 'package:amp_presets/settings_crud/widgets/equalization_slider.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/effect.dart';
import '../../persistance/models/setting.dart';
import 'effect_list_dialog.dart';

class EffectCard extends StatefulWidget {
  const EffectCard(this.setting, this.setSetting, {Key? key}) : super(key: key);

  final Setting setting;
  final Function setSetting;

  @override
  State<EffectCard> createState() => _EffectCardState();
}

class _EffectCardState extends State<EffectCard> {
  late List<Effect> effects;
  Effect selectedEffect = Effect();

  @override
  void initState() {
    getEffects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    selectedEffect.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  IconButton(
                      onPressed: () => showEffectListDialog(),
                      icon: const Icon(Icons.edit_rounded))
                ],
              ),
              const SizedBox(height: 15),
              ParameterSlider(selectedEffect.param1,
                  (double paramValue) => setParam1(paramValue),
                  value: widget.setting.param1),
              ParameterSlider(selectedEffect.param2,
                  (double paramValue) => setParam2(paramValue),
                  value: widget.setting.param2),
              ParameterSlider(selectedEffect.param3,
                  (double paramValue) => setParam3(paramValue),
                  value: widget.setting.param3),
            ],
          ),
        ),
      ),
    );
  }

  void getEffects() {
    EffectService().findAll().then((value) {
      effects = value;
      setState(() {
        selectedEffect = effects.firstWhere(
            (effect) => effect.id == widget.setting.effect.id,
            orElse: () => effects[0]);
      });
    });
  }

  showEffectListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EffectListDialog(
          effects: effects,
          selectedEffect: selectedEffect,
          onSelectedEffect: onSelectedEffect,
        );
      },
    );
  }

  onSelectedEffect(Effect effect) {
    selectedEffect = effect;
    Navigator.of(context).pop();
    setState(() {
      widget.setting.effect = effect;
    });
  }

  setParam1(double paramValue) {
    setState(() {
      widget.setting.param1 = paramValue;
    });
  }

  setParam2(double paramValue) {
    setState(() {
      widget.setting.param2 = paramValue;
    });
  }

  setParam3(double paramValue) {
    setState(() {
      widget.setting.param3 = paramValue;
    });
  }
}
