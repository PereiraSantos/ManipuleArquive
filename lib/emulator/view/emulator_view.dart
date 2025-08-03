import 'package:flutter/material.dart';
import 'package:manipule_arquive/emulator/view_model/emulator_view_model.dart';

import 'package:manipule_arquive/widgets/button_dropdown.dart';

class EmulatorView extends StatelessWidget {
  const EmulatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonDropdown(buildCommandFactory: EmulatorViewModel());
  }
}
