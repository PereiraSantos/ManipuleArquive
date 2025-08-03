import 'package:flutter/material.dart';
import 'package:manipule_arquive/projects/view_model/project_view_model.dart';

import 'package:manipule_arquive/widgets/button_dropdown.dart';

class ProjectView extends StatelessWidget {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonDropdown(buildCommandFactory: ProjectViewModel());
  }
}
