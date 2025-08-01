import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:manipule_arquive/transfer/enum/action.dart';
import 'package:manipule_arquive/transfer/view_model/database.dart';

import 'package:manipule_arquive/transfer/view_model/download.dart';
import 'package:manipule_arquive/transfer/view_model/local.dart';
import 'package:manipule_arquive/transfer/view_model/shared.dart';
import 'package:manipule_arquive/transfer/view_model/transfer_view_model.dart';
import 'package:manipule_arquive/transfer/widgets/list_title.dart';

class TransferView extends StatelessWidget {
  const TransferView({super.key, required this.project, required this.database, required this.shared, required this.path});

  final String project;
  final String database;
  final String shared;
  final String path;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferViewModel, ActionEnum>(
      builder: (context, action) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Selecione a ação')),
          ListTitle(
            onChanged: (value) {
              context.read<TransferViewModel>().selected(value!, Download(path));
            },
            groupValue: action,
            label: 'Enviar para download',
            value: ActionEnum.download,
          ),
          ListTitle(
            onChanged: (value) {
              context.read<TransferViewModel>().selected(value!, Database(path, project));
            },
            groupValue: action,
            label: 'Enviar para database',
            value: ActionEnum.database,
          ),
          ListTitle(
            onChanged: (value) {
              context.read<TransferViewModel>().selected(value!, Shared(path, project));
            },
            groupValue: action,
            label: 'Enviar para shared preference',
            value: ActionEnum.shared,
          ),
          ListTitle(
            onChanged: (value) {
              context.read<TransferViewModel>().selected(value!, Local(database, shared, project, path));
            },
            groupValue: action,
            label: 'Salvar na pasta local',
            value: ActionEnum.local,
          ),
        ],
      ),
    );
  }
}
