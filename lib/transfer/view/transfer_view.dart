import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/transfer/enum/action.dart';
import 'package:manipule_arquive/transfer/view_model/database.dart';
import 'package:manipule_arquive/transfer/view_model/download.dart';
import 'package:manipule_arquive/transfer/view_model/local.dart';
import 'package:manipule_arquive/transfer/view_model/shared.dart';
import 'package:manipule_arquive/transfer/view_model/transfer_view_model.dart';
import 'package:manipule_arquive/transfer/widgets/list_title.dart';
import 'package:manipule_arquive/usercases/button_drop_down_cache.dart';
import 'package:manipule_arquive/widgets/directory_path/directory_path.dart';
import 'package:manipule_arquive/widgets/directory_path/directory_path_factory.dart';

// ignore: must_be_immutable
class TransferView extends StatelessWidget {
  TransferView({super.key});

  String folder = '';
  String arquive = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferViewModel, ActionEnum>(
      builder: (context, action) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 3, top: 2),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DirectoryPath(
                  label: 'Arquivo',
                  title: 'Origem',
                  onClick: (path) => arquive = path,
                  directoryPathFactory: ArquivoPath(),
                ),
                const Padding(padding: EdgeInsets.all(8.0), child: Text('Enviar para')),
                Row(
                  children: [
                    Expanded(
                      child: ListTitle(
                        onChanged: (value) {
                          context.read<TransferViewModel>().selected(value!, Download(arquive));
                        },
                        groupValue: action,
                        label: 'Download',
                        value: ActionEnum.download,
                      ),
                    ),
                    Expanded(
                      child: ListTitle(
                        onChanged: (value) {
                          context.read<TransferViewModel>().selected(value!, Database(arquive, ButtonDropDownCache().project ?? ''));
                        },
                        groupValue: action,
                        label: 'Database',
                        value: ActionEnum.database,
                      ),
                    ),
                    Expanded(
                      child: ListTitle(
                        onChanged: (value) {
                          context.read<TransferViewModel>().selected(value!, Shared(arquive, ButtonDropDownCache().project ?? ''));
                        },
                        groupValue: action,
                        label: 'Shared preference',
                        value: ActionEnum.shared,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 3, top: 2),
            elevation: 8,
            child: DirectoryPath(
              label: 'Pasta',
              title: 'Salvar na pasta',
              onClick: (path) {
                context.read<TransferViewModel>().selected(
                      null,
                      Local(
                        ButtonDropDownCache().database,
                        ButtonDropDownCache().shared,
                        ButtonDropDownCache().project ?? '',
                        path,
                      ),
                    );
              },
              directoryPathFactory: FolderPath(),
            ),
          ),
        ],
      ),
    );
  }
}
