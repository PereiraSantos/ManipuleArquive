import 'package:manipule_arquive/transfer/view_model/command_transfer_factory.dart';

class Database implements CommandTransferFactory {
  String path;
  String project;

  Database(this.path, this.project);

  @override
  String createCommand() {
    return 'adb push $path /data/data/$project/databases/';
  }
}
