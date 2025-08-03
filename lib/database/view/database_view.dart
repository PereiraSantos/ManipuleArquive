import 'package:flutter/material.dart';
import 'package:manipule_arquive/database/view_model/database_view_model.dart';
import 'package:manipule_arquive/widgets/button_dropdown.dart';

class DatabaseView extends StatelessWidget {
  const DatabaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonDropdown(buildCommandFactory: DatabaseViewModel());
  }
}
