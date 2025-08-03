import 'package:manipule_arquive/usercases/button_drop_down_cache.dart';
import 'package:manipule_arquive/utils/build_command_factory.dart';
import 'package:manipule_arquive/utils/command.dart';

class ProjectViewModel implements BuildCommandFactory {
  final Command command = Command();

  @override
  Future<List<String>> build(String platform) async {
    await command.processStart('adb shell ls /data/data/', platform);
    return command.buildProject();
  }

  @override
  String get title => 'Projetos';

  @override
  void select(String? value) => ButtonDropDownCache().setProject = value;
}
