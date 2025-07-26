import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownViewModel extends Cubit<bool> {
  DropdownViewModel() : super(false);

  List<String> lists = [];
  String? _selected;

  String get selected => _selected ?? '';
  set selected(String value) => _selected = value;

  void dropDownItemSelected(String? novoItem, bool loading) {
    if (novoItem == null) return;

    _selected = novoItem;

    emit(!loading);
  }

  void chancheLoading(bool value) {
    emit(value);
  }
}
