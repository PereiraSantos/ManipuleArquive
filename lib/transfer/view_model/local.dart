import 'package:manipule_arquive/transfer/view_model/command_transfer_factory.dart';

class Local implements CommandTransferFactory {
  String? database;
  String? shared;
  String project;
  String path;

  Local(this.database, this.shared, this.project, this.path);
  @override
  String createCommand() {
    String? command;
    if (database != null) command = 'adb pull /data/data/$project/databases/$database $path';
    if (shared != null && command == null) command = 'adb pull /data/data/$project/shared_prefs/$shared $path';
    if (shared != null && command != null) command = '$command; adb pull /data/data/$project/shared_prefs/$shared $path';

    return command!;
  }
}
