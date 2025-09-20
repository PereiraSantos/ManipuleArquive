import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/transfer/enum/action.dart';
import 'package:manipule_arquive/transfer/view_model/command_transfer_factory.dart';

class TransferViewModel extends Cubit<ActionEnum> {
  TransferViewModel() : super(ActionEnum.download);

  String commandTransfer = '';

  void selected(ActionEnum? value, CommandTransferFactory commandTransferFactory) {
    if (value != null) emit(value);
    commandTransfer = commandTransferFactory.createCommand();
  }
}
