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
      builder: (context, loading) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 05, top: 10),
            child: Text(buildCommandFactory.title),
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
                      context.read<DropdownViewModel>().chancheLoading(true);

                      // ignore: use_build_context_synchronously
                      context.read<DropdownViewModel>().lists = await buildCommandFactory.build(Theme.of(context).platform.name);
                      // ignore: use_build_context_synchronously
                      context.read<DropdownViewModel>().chancheLoading(false);
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
                    visible: context.read<DropdownViewModel>().lists.isNotEmpty,
                    replacement: const Text('Não há emuladores.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: context.read<DropdownViewModel>().lists.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
