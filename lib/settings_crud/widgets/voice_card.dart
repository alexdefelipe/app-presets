import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';

class VoiceCard extends StatefulWidget {
  const VoiceCard(this.setting, this.setSetting, {Key? key}) : super(key: key);

  final Setting setting;
  final Function setSetting;

  @override
  State<VoiceCard> createState() => _VoiceCardState();
}

class _VoiceCardState extends State<VoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Voice",
                  style: Theme.of(context).textTheme.headline4,
                ),
                _getVoiceDropdown()
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton _getVoiceDropdown() {
    return DropdownButton<String>(
      value: widget.setting.voice,
      underline: Container(
        height: 2,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newVoice) {
        if (newVoice == null) {
          return;
        }

        setState(() {
          widget.setting.voice = newVoice;
          widget.setSetting(widget.setting);
        });
      },
      items: <String>['Clean', 'Crunch', 'Lead', 'Overdrive 1', 'Overdrive 2']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
