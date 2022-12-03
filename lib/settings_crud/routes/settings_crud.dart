import 'package:amp_presets/persistance/services/setting_service.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';
import '../widgets/effect_card.dart';
import '../widgets/equalization_card.dart';
import '../widgets/track_card.dart';
import '../widgets/voice_card.dart';

class SettingCrud extends StatefulWidget {
  const SettingCrud({Key? key}) : super(key: key);

  @override
  State<SettingCrud> createState() => _SettingCrudState();
}

class _SettingCrudState extends State<SettingCrud> {
  late Setting setting;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      setting =
          (ModalRoute.of(context)!.settings.arguments ?? Setting()) as Setting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(setting.id == null ? 'Create preset' : 'Edit preset'),
        actions: [
          IconButton(
              onPressed: () async => onSavePressed(),
              icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TrackCard(setting, setTrackName, setTrackArtist),
            EqualizationCard(setting, setSetting),
            EffectCard(setting, setSetting),
            VoiceCard(setting, setSetting)
          ],
        ),
      ),
    );
  }

  void setTrackName(String trackName) {
    setState(() {
      setting.track.name = trackName;
    });
  }

  void setTrackArtist(String artist) {
    setState(() {
      setting.track.artist = artist;
    });
  }

  void setSetting(Setting setting) {
    setState(() {
      this.setting = setting;
    });
  }

  void onSavePressed() async {
    await (setting.id != null
        ? SettingService().update(setting)
        : SettingService().create(setting));
    Navigator.pop(context);
  }
}
