import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/database/view_model/database_view_model.dart';
import 'package:manipule_arquive/projects/view_model/project_view_model.dart';
import 'package:manipule_arquive/utils/command.dart';

class DatabaseView extends StatelessWidget {
  DatabaseView({super.key, required this.projectViewModel});

  final ProjectViewModel projectViewModel;
  final Command command = Command();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseViewModel, bool>(
      builder: (context, loading) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 05, top: 10),
            child: Text('Banco de dados:'),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      context.read<DatabaseViewModel>().chancheLoading(true);

                      await command.processStart('adb shell ls /data/data/${projectViewModel.selected}/databases/');
                      List<String> list = command.buildDatabase();

                      // ignore: use_build_context_synchronously
                      context.read<DatabaseViewModel>().lists = list;
                      // ignore: use_build_context_synchronously
                      context.read<DatabaseViewModel>().chancheLoading(false);
                    },
                    child: const SizedBox(
                      height: 25,
                      child: Icon(Icons.refresh_rounded),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: context.read<DatabaseViewModel>().lists.isNotEmpty,
                    replacement: const Text('Não há banco'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: context.read<DatabaseViewModel>().lists.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => context.read<DatabaseViewModel>().dropDownItemSelected(item, loading),
                      value: context.read<DatabaseViewModel>().selected,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
