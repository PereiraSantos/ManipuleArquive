import 'package:manipule_arquive/transfer/view_model/command_transfer_factory.dart';

class Download implements CommandTransferFactory {
  String path;

  Download(this.path);

  @override
  String createCommand() {
    return 'adb push $path /sdcard/Download/';
  }
}
