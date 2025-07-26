import 'package:flutter/material.dart';
import 'package:manipule_arquive/transfer/enum/action.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.value,
  });

  final Function(ActionEnum? value) onChanged;
  final ActionEnum groupValue;
  final String label;
  final ActionEnum value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label),
      leading: Radio<ActionEnum>(
        value: value,
        groupValue: groupValue,
        onChanged: (ActionEnum? value) => onChanged(value),
      ),
    );
  }
}
