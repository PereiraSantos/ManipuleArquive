import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/usercases/dropdown_view_model.dart';
import 'package:manipule_arquive/utils/build_command_factory.dart';

class ButtonDropdown extends StatelessWidget {
  const ButtonDropdown({super.key, required this.buildCommandFactory});

  final BuildCommandFactory buildCommandFactory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownViewModel, bool>(
      builder: (context, loading) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.only(left: 2, right: 2, bottom: 3, top: 2),
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Visibility(
                visible: context.read<DropdownViewModel>().lists.isNotEmpty,
                replacement: const Text(
                  'Não há emuladores.',
                  style: TextStyle(fontSize: 12),
                ),
                child: DropdownButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  isDense: true,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  isExpanded: true,
                  items: context.read<DropdownViewModel>().lists.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? item) {
                    buildCommandFactory.select(item);

                    context.read<DropdownViewModel>().dropDownItemSelected(item, loading);
                  },
                  value: context.read<DropdownViewModel>().selected,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 2),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    context.read<DropdownViewModel>().chancheLoading(true);

                    // ignore: use_build_context_synchronously
                    context.read<DropdownViewModel>().lists = await buildCommandFactory.build(Theme.of(context).platform.name);
                    // ignore: use_build_context_synchronously
                    context.read<DropdownViewModel>().chancheLoading(false);
                  },
                  child: const SizedBox(
                    height: 20,
                    child: Text('Recarregar.'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
