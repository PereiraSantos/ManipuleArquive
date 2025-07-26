import 'package:manipule_arquive/transfer/view_model/command_transfer_factory.dart';

class Shared implements CommandTransferFactory {
  String path;
  String project;

  Shared(this.path, this.project);

  @override
  String createCommand() {
    return 'adb push $path /data/data/$project/shared_prefs/';
  }
}
