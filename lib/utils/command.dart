import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

abstract class CommandFactory {
  Future<void> processStart(String command, String platform);
  List<String> buildEmulater();
  List<String> buildProject();
  List<String> buildDatabase();
  List<String> buildShared();
  bool isRoot();
}

class Command implements CommandFactory {
  String? stderrData;
  List<String> list = [];

  @override
  Future<void> processStart(String command, String platform) async {
    stderrData = null;
    list = [];

    try {
      final Process process;

      if (platform == 'windows') {
        process = await Process.start('cmd.exe', ['/c', command], runInShell: false);
      } else {
        process = await Process.start('sh', ['-c', command], runInShell: true);
      }

      process.stdout.transform(const Utf8Decoder()).transform(const LineSplitter()).listen((data) {
        if (data != '' && data != 'List of devices attached') list.add(data);
      });

      process.stderr.transform(const Utf8Decoder()).listen((data) => stderrData = data);

      await process.exitCode;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  List<String> buildEmulater() => ['Selecione o emulador', ...list];

  @override
  bool isRoot() => list.contains("adbd is already running as root");

  @override
  List<String> buildProject() => ['Selecione o projeto', ...list];

  @override
  List<String> buildDatabase() => ['Selecione o banco', ...list];

  @override
  List<String> buildShared() => ['Selecione o shared', ...list];

  void reset() => stderrData = null;
}
