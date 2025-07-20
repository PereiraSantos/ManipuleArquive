import 'package:flutter/material.dart';
import 'package:manipule_arquive/dashboard/dashboard.dart';
import 'package:manipule_arquive/enum/action.dart';

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({super.key, required this.selectActionType});

  final SelectActionType selectActionType;

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  ActionEnum? acation = ActionEnum.download;

  _update(ActionEnum? value) {
    setState(() => acation = value);
    widget.selectActionType(acation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: const Text('Enviar para download'),
          leading: Radio<ActionEnum>(
            value: ActionEnum.download,
            groupValue: acation,
            onChanged: (ActionEnum? value) => _update(value),
          ),
        ),
        ListTile(
          dense: true,
          title: const Text('Enviar para database'),
          leading: Radio<ActionEnum>(
            value: ActionEnum.database,
            groupValue: acation,
            onChanged: (ActionEnum? value) => _update(value),
          ),
        ),
        ListTile(
          dense: true,
          title: const Text('Enviar para shared preference'),
          leading: Radio<ActionEnum>(
            value: ActionEnum.shared,
            groupValue: acation,
            onChanged: (ActionEnum? value) => _update(value),
          ),
        ),
        ListTile(
          dense: true,
          title: const Text('Salvar na pasta local'),
          leading: Radio<ActionEnum>(
            value: ActionEnum.local,
            groupValue: acation,
            onChanged: (ActionEnum? value) => _update(value),
          ),
        ),
      ],
    );
  }
}
