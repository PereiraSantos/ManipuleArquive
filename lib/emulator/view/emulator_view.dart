import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/emulator/view_model/emulator_view_model.dart';
import 'package:manipule_arquive/utils/command.dart';

class EmulatorView extends StatelessWidget {
  EmulatorView({super.key});

  final Command command = Command();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmulatorViewModel, bool>(
      builder: (context, loading) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 05, top: 10),
            child: Text('Emuladores:'),
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
                      context.read<EmulatorViewModel>().chancheLoading(true);

                      await command.processStart('adb devices');
                      List<String> list = command.buildEmulater();

                      // ignore: use_build_context_synchronously
                      context.read<EmulatorViewModel>().lists = list;
                      // ignore: use_build_context_synchronously
                      context.read<EmulatorViewModel>().chancheLoading(false);
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
                    visible: context.read<EmulatorViewModel>().lists.isNotEmpty,
                    replacement: const Text('Não há emuladores.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: context.read<EmulatorViewModel>().lists.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => context.read<EmulatorViewModel>().dropDownItemSelected(item, loading),
                      value: context.read<EmulatorViewModel>().selected,
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
