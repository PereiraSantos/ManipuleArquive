import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/emulator/view_model/emulator_view_model.dart';
import 'package:manipule_arquive/utils/command.dart';

// ignore: must_be_immutable
class ModoRootView extends StatelessWidget {
  ModoRootView({super.key});

  final Command command = Command();
  bool modoRoot = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmulatorViewModel, bool>(builder: (context, loading) {
      bool root = modoRoot && context.read<EmulatorViewModel>().lists.length > 1;

      if (context.read<EmulatorViewModel>().lists.isEmpty || context.read<EmulatorViewModel>().selected == 'Selecione o emulador') return const SizedBox();

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 05, top: 10),
            child: Text('Modo root:'),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    if (context.read<EmulatorViewModel>().selected == 'Selecione o emulador') return;

                    context.read<EmulatorViewModel>().chancheLoading(true);
                    await command.processStart('adb root');
                    modoRoot = command.isRoot();

                    // ignore: use_build_context_synchronously
                    context.read<EmulatorViewModel>().chancheLoading(false);
                  },
                  child: Container(
                    height: 25,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Icon(Icons.refresh_rounded),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: root ? Colors.green : Colors.grey),
                      Text(root ? 'Em modo root' : 'Em modo padrão', style: TextStyle(color: root ? Colors.green : Colors.grey)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
