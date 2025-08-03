import 'package:manipule_arquive/usercases/button_drop_down_cache.dart';
import 'package:manipule_arquive/utils/build_command_factory.dart';
import 'package:manipule_arquive/utils/command.dart';

class SharedPrefsViewModel implements BuildCommandFactory {
  SharedPrefsViewModel();

  final Command command = Command();

  @override
  Future<List<String>> build(String platform) async {
    await command.processStart('adb shell ls /data/data/${ButtonDropDownCache().project}/shared_prefs/', platform);
    return command.buildShared();
  }

  @override
  String get title => 'Shared preferneces';

  @override
  void select(String? value) => ButtonDropDownCache().setShared = value;
}
