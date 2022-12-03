import 'package:amp_presets/persistance/services/setting_service.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';

class TrackCard extends StatelessWidget {
  const TrackCard(this.setting, this.setTrackName, this.setTrackArtist,
      {Key? key})
      : super(key: key);

  final Setting setting;
  final Function setTrackName;
  final Function setTrackArtist;

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
                'Track',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: TextEditingController()..text = setting.track.name,
                decoration: const InputDecoration(
                  labelText: 'Track name',
                ),
                onChanged: (trackName) => setTrackName(trackName),
              ),
              const SizedBox(height: 15),
              Autocomplete<String>(
                initialValue: TextEditingValue(text: setting.track.artist),
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  setTrackArtist(textEditingValue.text);
                  Set<String> artists = (await SettingService().getSettings())
                      .map<String>((setting) => setting.track.artist)
                      .toSet();
                  return artists.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (selectedArtist) => setTrackArtist(selectedArtist),
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: 'Artist',
                    ),
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
