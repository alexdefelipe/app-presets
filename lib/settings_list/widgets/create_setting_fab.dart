import 'package:flutter/material.dart';

import '../../settings_crud/routes/settings_crud.dart';

class CreateSettingFAB extends StatelessWidget {
  const CreateSettingFAB({required this.onCreateSetting, Key? key})
      : super(key: key);

  final Function onCreateSetting;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _navigateToCrudRoute(context),
      child: const Icon(Icons.add),
    );
  }

  void _navigateToCrudRoute(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingCrud()),
    );

    onCreateSetting();
  }
}
