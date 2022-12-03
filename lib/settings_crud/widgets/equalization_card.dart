import 'package:amp_presets/settings_crud/widgets/equalization_slider.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';

class EqualizationCard extends StatelessWidget {
  const EqualizationCard(this.setting, this.setSetting, {Key? key})
      : super(key: key);

  final Setting setting;
  final Function setSetting;

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
              Text(
                'Equalization',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 15),
              ParameterSlider('Gain', (double gain) => setGain(gain),
                  value: setting.gain),
              ParameterSlider('Volume', (double volume) => setVolume(volume),
                  value: setting.volume),
              ParameterSlider('Bass', (double bass) => setBass(bass),
                  value: setting.bass),
              ParameterSlider('Middle', (double middle) => setMiddle(middle),
                  value: setting.middle),
              ParameterSlider('Treble', (double treble) => setTreble(treble),
                  value: setting.treble),
            ],
          ),
        ),
      ),
    );
  }

  setBass(double bass) {
    setting.bass = bass;
    setSetting(setting);
  }

  setMiddle(double middle) {
    setting.middle = middle;
    setSetting(setting);
  }

  setTreble(double treble) {
    setting.treble = treble;
    setSetting(setting);
  }

  setGain(double gain) {
    setting.gain = gain;
    setSetting(setting);
  }

  setVolume(double volume) {
    setting.volume = volume;
    setSetting(setting);
  }
}
