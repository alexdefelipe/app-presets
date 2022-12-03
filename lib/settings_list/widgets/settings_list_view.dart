import 'package:amp_presets/persistance/services/setting_service.dart';
import 'package:flutter/material.dart';

import '../../persistance/models/setting.dart';
import '../../settings_crud/routes/settings_crud.dart';
import 'equalization_spinner.dart';

class SettingsListView extends StatefulWidget {
  const SettingsListView(this.settings,
      {required this.onDeleteSetting,
      required this.onSettingLongPress,
      Key? key})
      : super(key: key);

  final List<Setting> settings;
  final Function onDeleteSetting;
  final Function onSettingLongPress;

  @override
  State<SettingsListView> createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return FutureBuilder<List<Setting>>(
        future: SettingService().getSettings(),
        builder: (context, AsyncSnapshot<List<Setting>> snapshot) {
          return ExpansionPanelList.radio(
            initialOpenPanelValue: 1,
            children: _getListChildren(),
            expansionCallback: expansionCallback,
          );
        });
  }

  List<ExpansionPanelRadio> _getListChildren() {
    return widget.settings
        .map<ExpansionPanelRadio>((Setting setting) => _buildRow(setting))
        .toList();
  }

  ExpansionPanelRadio _buildRow(Setting setting) {
    return ExpansionPanelRadio(
      value: setting.id ?? 0,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return GestureDetector(
            onLongPress: () =>
                widget.onSettingLongPress(_getCrudAppBar(setting)),
            child: ListTile(
                title: Text(setting.track.name),
                subtitle: Text(setting.track.artist)));
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Equalization", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 10,),
            Text(setting.voice, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EqualizationSpinner('Gain', setting.gain, _controller),
                EqualizationSpinner('Volume', setting.volume, _controller),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EqualizationSpinner('Treble', setting.treble, _controller),
                EqualizationSpinner('Middle', setting.middle, _controller),
                EqualizationSpinner('Bass', setting.bass, _controller),
              ],
            ),
            Text(setting.effect.name,
                style: Theme.of(context).textTheme.headline6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EqualizationSpinner(
                    setting.effect.param1, setting.param1, _controller),
                EqualizationSpinner(
                    setting.effect.param2, setting.param2, _controller),
                EqualizationSpinner(
                    setting.effect.param3, setting.param3, _controller)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void expansionCallback(int panelIndex, bool isExpanded) {
    restartAnimation();
    widget.onSettingLongPress(null);
  }

  void restartAnimation() {
    _controller.value = 0;
    _controller.forward();
  }

  showDeleteDialog(Setting setting) {
    Widget cancelButton = TextButton(
      child: const Text('Cancelar'),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: const Text('Aceptar'),
      onPressed: () => onClickDelete(setting),
    );
    AlertDialog alert = AlertDialog(
      title: const Text('Borrar ajuste'),
      content:
          Text('¿Deseas borrar el ajuste para el tema ${setting.track.name}?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onClickDelete(Setting setting) async {
    await SettingService().delete(setting);
    Navigator.of(context).pop();
    widget.onDeleteSetting();
    widget.onSettingLongPress(null);
  }

  AppBar _getCrudAppBar(Setting setting) {
    return AppBar(
      title: Text(setting.track.name),
      leading: IconButton(
          onPressed: () => widget.onSettingLongPress(null),
          icon: const Icon(Icons.arrow_back)),
      actions: [
        IconButton(
          onPressed: () => showDeleteDialog(setting),
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () => _navigateToCrudRoute(context, setting),
          icon: const Icon(Icons.edit),
        ),
      ],
      backgroundColor: Colors.accents[0],
    );
  }

  void _navigateToCrudRoute(BuildContext context, Setting setting) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingCrud(),
        settings: RouteSettings(arguments: setting),
      ),
    );
    widget.onSettingLongPress(null);
    widget.onDeleteSetting();
  }
}
