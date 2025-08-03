import 'package:flutter/material.dart';

import 'package:manipule_arquive/shared_prefs/view_model/shared_prefs_view_model.dart';

import 'package:manipule_arquive/widgets/button_dropdown.dart';

class SharedPrefsView extends StatelessWidget {
  const SharedPrefsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonDropdown(buildCommandFactory: SharedPrefsViewModel());
  }
}
