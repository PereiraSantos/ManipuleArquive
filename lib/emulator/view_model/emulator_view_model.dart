import 'package:manipule_arquive/usercases/button_drop_down_cache.dart';
import 'package:manipule_arquive/utils/build_command_factory.dart';
import 'package:manipule_arquive/utils/command.dart';

class EmulatorViewModel implements BuildCommandFactory {
  final Command command = Command();

  @override
  Future<List<String>> build(String platform) async {
    await command.processStart('adb devices', platform);
    return command.buildEmulater();
  }

  @override
  String get title => 'Emuladores';

  @override
  void select(String? value) => ButtonDropDownCache().setEmulator = value;
}
