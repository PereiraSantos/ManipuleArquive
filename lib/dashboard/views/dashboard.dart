import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipule_arquive/database/view/database_view.dart';
import 'package:manipule_arquive/modo_root/view/modo_root_view.dart';
import 'package:manipule_arquive/projects/view/project_view.dart';
import 'package:manipule_arquive/shared_prefs/view/shared_prefs_view.dart';
import 'package:manipule_arquive/transfer/view/transfer_view.dart';
import 'package:manipule_arquive/transfer/view_model/transfer_view_model.dart';
import 'package:manipule_arquive/usercases/dropdown_view_model.dart';

import 'package:manipule_arquive/utils/command.dart';
import 'package:manipule_arquive/widgets/elevated_button_widget.dart';

import '../../emulator/view/emulator_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String folder = 'arquivo';
  TextEditingController controller = TextEditingController();
  bool messageAction = false;
  String? messageActionFinishSucces;
  String? messageActionFinishErro;

  _update() => setState(() {});

  DropdownViewModel emulatorsViewModel = DropdownViewModel()..selected = 'Selecione o emulador';
  DropdownViewModel projectViewModel = DropdownViewModel()..selected = 'Selecione o projeto';
  DropdownViewModel databaseViewModel = DropdownViewModel()..selected = 'Selecione o banco';
  DropdownViewModel sharedPrefsViewModel = DropdownViewModel()..selected = 'Selecione o shared';
  TransferViewModel transferViewModel = TransferViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocProvider(
                    create: (_) => emulatorsViewModel,
                    child: const EmulatorView(),
                  ),
                  BlocProvider(
                    create: (_) => emulatorsViewModel,
                    child: ModoRootView(),
                  ),
                  BlocProvider(
                    create: (_) => projectViewModel,
                    child: const ProjectView(),
                  ),
                  BlocProvider(
                    create: (_) => transferViewModel,
                    child: TransferView(path: controller.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(labelText: 'Selecionar $folder'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocProvider(
                    create: (_) => databaseViewModel,
                    child: const DatabaseView(),
                  ),
                  BlocProvider(
                    create: (_) => sharedPrefsViewModel,
                    child: const SharedPrefsView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Visibility(
          visible: messageAction,
          child: Text(
            messageActionFinishErro ?? messageActionFinishSucces ?? '',
            style: TextStyle(color: messageActionFinishErro != null ? Colors.red : Colors.green),
          ),
        ),
        ElevatedButtonWidget(
          onPressed: () {
            controller.clear();
            _update();
          },
          label: 'Resetar',
          loading: false,
        ),
        ElevatedButtonWidget(
          onPressed: () async {
            messageActionFinishSucces = null;
            messageActionFinishErro = null;

            await Command().processStart(transferViewModel.commandTransfer, Theme.of(context).platform.name);
            _update();
          },
          label: 'Concluir',
          loading: false,
        ),
      ],
    );
  }
}
