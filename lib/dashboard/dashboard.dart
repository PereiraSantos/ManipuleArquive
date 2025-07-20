import 'package:flutter/material.dart';
import 'package:manipule_arquive/enum/action.dart';

import 'package:manipule_arquive/utils/command.dart';
import 'package:manipule_arquive/widgets/elevated_button_widget.dart';
import 'package:manipule_arquive/widgets/radio_button_widget.dart';

typedef SelectActionType = void Function(ActionEnum? acation);

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Command command = Command();
  bool _loading = false;
  bool _loadingProject = false;
  bool _loadingRoot = false;
  bool _loadingDatabase = false;
  bool _loadingShared = false;
  ActionEnum? action;
  late SelectActionType selectActionType;
  String folder = 'arquivo';
  bool modoRoot = false;
  TextEditingController controller = TextEditingController();
  bool messageAction = false;
  String? messageActionFinishSucces;
  String? messageActionFinishErro;

  _update() => setState(() {});

  void _dropDownItemSelected(String? novoItem) {
    if (novoItem == null) return;

    command.emulatorsSelected = novoItem;

    _update();
  }

  void _dropDownItemProjectSelected(String? novoItem) {
    if (novoItem == null) return;

    command.projectSelected = novoItem;

    _update();
  }

  void _dropDownItemDatabaseSelected(String? novoItem) {
    if (novoItem == null) return;

    command.selectDatabase = novoItem;

    _update();
  }

  void _dropDownItemSharedSelected(String? novoItem) {
    if (novoItem == null) return;

    command.selectShared = novoItem;

    _update();
  }

  void _chancheLoading(bool value) => _loading = value;
  void _chancheLoadingProject(bool value) => _loadingProject = value;
  void _chancheRootLoading(bool value) => _loadingRoot = value;
  void _chancheDatabaseLoading(bool value) => _loadingDatabase = value;
  void _chancheSharedLoading(bool value) => _loadingShared = value;
  void selectActions(ActionEnum? value) {
    action = value;

    folder = action?.name == ActionEnum.local.name ? 'pasta' : 'arquivo';
    _update();
  }

  @override
  void initState() {
    super.initState();
    selectActionType = selectActions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButtonWidget(
                  onPressed: () async {
                    _chancheLoading(true);
                    _update();

                    await command.processStart('adb devices');
                    command.buildEmulater();
                    _chancheLoading(false);
                    _update();
                  },
                  label: 'Lista emuladores',
                  loading: _loading,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: command.emulators.isNotEmpty,
                    replacement: const Text('Não há emuladores.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: command.emulators.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => _dropDownItemSelected(item),
                      value: command.emulatorsSelected,
                    ),
                  ),
                ),
                Visibility(
                  visible: command.emulators.length > 1,
                  child: ElevatedButtonWidget(
                    onPressed: () async {
                      _chancheRootLoading(true);
                      _update();
                      await command.processStart('adb root');
                      modoRoot = command.isRoot();
                      _chancheRootLoading(false);
                      _update();
                    },
                    label: 'Modo root',
                    loading: _loadingRoot,
                  ),
                ),
                Visibility(
                  visible: modoRoot && command.emulators.length > 1,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        Text('Em modo root', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !modoRoot && command.emulators.length > 1,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.grey),
                        Text('Em modo padrão', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                ElevatedButtonWidget(
                  onPressed: () async {
                    _chancheLoadingProject(true);
                    _update();

                    await command.processStart('adb shell ls /data/data/');
                    command.buildProject();
                    _chancheLoadingProject(false);
                    _update();
                  },
                  label: 'Lista projetos',
                  loading: _loadingProject,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: command.projects.isNotEmpty,
                    replacement: const Text('Não há projetos.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: command.projects.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => _dropDownItemProjectSelected(item),
                      value: command.projectSelected,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8.0), child: Text('Selecione a ação')),
                RadioButtonWidget(selectActionType: selectActionType),
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
                ElevatedButtonWidget(
                  onPressed: () async {
                    _chancheDatabaseLoading(true);
                    _update();

                    await command.processStart('adb shell ls /data/data/${command.projectSelected}/databases/');
                    command.buildDatabase();
                    _chancheDatabaseLoading(false);
                    _update();
                  },
                  label: 'Lista banco',
                  loading: _loadingDatabase,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: command.databases.isNotEmpty,
                    replacement: const Text('Não há banco.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: command.databases.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => _dropDownItemDatabaseSelected(item),
                      value: command.selectDatabase,
                    ),
                  ),
                ),
                ElevatedButtonWidget(
                  onPressed: () async {
                    _chancheSharedLoading(true);
                    _update();

                    await command.processStart('adb shell ls /data/data/${command.projectSelected}/shared_prefs/');
                    command.buildShared();
                    _chancheSharedLoading(false);
                    _update();
                  },
                  label: 'Lista shared preferences.',
                  loading: _loadingShared,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: command.shareds.isNotEmpty,
                    replacement: const Text('Não há shared preferences.'),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isDense: false,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      isExpanded: true,
                      items: command.shareds.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String? item) => _dropDownItemSharedSelected(item),
                      value: command.selectShared,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            command.reset();
            controller.clear();
            _update();
          },
          label: 'Resetar',
          loading: _loadingRoot,
        ),
        ElevatedButtonWidget(
          onPressed: () async {
            messageActionFinishSucces = null;
            messageActionFinishErro = null;

            if (command.selectDatabase != 'Selecionea database') {
              await command.processStart('adb pull /data/data/${command.projectSelected}/databases/${command.selectDatabase} ${controller.text}');
            }
            if (command.selectShared != 'Selecione shared') {
              await command.processStart('adb pull /data/data/${command.projectSelected}/shared_prefs/${command.selectShared} ${controller.text}');
            }
            if (action?.name == ActionEnum.download.name) {
              await command.processStart('adb push ${controller.text} /sdcard/Download/');
            }

            if (action?.name == ActionEnum.database.name) {
              await command.processStart('adb  push ${controller.text} /data/data/${command.projectSelected}/databases/ ');
            }
            if (action?.name == ActionEnum.shared.name) {
              await command.processStart('adb push ${controller.text} /data/data/${command.projectSelected}/shared_prefs');
            }

            messageAction = true;
            if (command.stdoutData == null) {
              messageActionFinishSucces = 'Ação concluída com sucesso.';
            } else {
              messageActionFinishErro = 'Ação concluída com erro.';
            }

            _update();
          },
          label: 'Concluir',
          loading: _loadingRoot,
        ),
      ],
    );
  }
}
