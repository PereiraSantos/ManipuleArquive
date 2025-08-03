import 'package:manipule_arquive/usercases/button_drop_down_cache.dart';
import 'package:manipule_arquive/utils/build_command_factory.dart';
import 'package:manipule_arquive/utils/command.dart';

class DatabaseViewModel implements BuildCommandFactory {
  DatabaseViewModel();

  final Command command = Command();

  @override
  Future<List<String>> build(String platform) async {
    await command.processStart('adb shell ls /data/data/${ButtonDropDownCache().project}/databases/', platform);
    return command.buildDatabase();
  }

  @override
  String get title => 'Banco de dados';

  @override
  void select(String? value) => ButtonDropDownCache().setDatabase = value;
}
