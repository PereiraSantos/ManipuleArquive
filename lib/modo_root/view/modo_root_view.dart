import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:manipule_arquive/usercases/dropdown_view_model.dart';
import 'package:manipule_arquive/utils/command.dart';

// ignore: must_be_immutable
class ModoRootView extends StatelessWidget {
  ModoRootView({super.key});

  final Command command = Command();
  bool modoRoot = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownViewModel, bool>(builder: (context, loading) {
      bool root = modoRoot && context.read<DropdownViewModel>().lists.length > 1;

      if (context.read<DropdownViewModel>().lists.isEmpty || context.read<DropdownViewModel>().selected == 'Selecione o emulador') return const SizedBox();

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    if (context.read<DropdownViewModel>().selected == 'Selecione o emulador') return;

                    context.read<DropdownViewModel>().chancheLoading(true);
                    await command.processStart('adb root', Theme.of(context).platform.name);
                    modoRoot = command.isRoot();

                    // ignore: use_build_context_synchronously
                    context.read<DropdownViewModel>().chancheLoading(false);
                  },
                  child: Container(
                    height: 25,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Ir para modo root'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: root ? Colors.green : Colors.grey),
                      Text(root ? 'Tipo de permisão root' : 'Tipo de permisão padrão', style: TextStyle(color: root ? Colors.green : Colors.grey)),
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
