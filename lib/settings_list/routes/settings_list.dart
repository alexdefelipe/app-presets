import 'package:amp_presets/settings_list/widgets/settings_list_view.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';
import '../../persistance/services/setting_service.dart';
import '../widgets/create_setting_fab.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  List<Setting> settings = [];
  late AppBar _appBar = _getDefaultAppBar();

  @override
  void initState() {
    // _appBar =
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Column(
        children: [
          Flexible(
            child: SettingsListView(settings,
                onDeleteSetting: getSettings,
                onSettingLongPress: _changeAppBar),
          ),
        ],
      ),
      floatingActionButton: CreateSettingFAB(onCreateSetting: getSettings),
    );
  }

  void getSettings() {
    SettingService().getSettings().then((value) {
      setState(() {
        settings = value;
      });
    });
  }

  void _changeAppBar(AppBar? appBar) {
    setState(() {
      _appBar = appBar ?? _getDefaultAppBar();
    });
  }

  AppBar _getDefaultAppBar() {
    return AppBar(
      title: Text(
        'Settings list',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
