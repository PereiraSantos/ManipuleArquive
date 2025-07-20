import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

abstract class CommandFactory {
  Future<void> processStart(String command);
  void buildEmulater();
  void buildProject();
  bool isRoot();
  void buildDatabase();
  void buildShared();
}

class Command implements CommandFactory {
  String? stdoutData;
  String? stderrData;
  List<String> emulators = [];
  List<String> projects = [];
  List<String> databases = [];
  List<String> shareds = [];
  String emulatorsSelected = 'Selecione o aparelho';
  String projectSelected = 'Selecione o projeto';
  String selectDatabase = 'Selecione database';
  String selectShared = 'Selecione shared';

  @override
  Future<void> processStart(String command) async {
    stdoutData = null;
    stderrData = null;
    try {
      final process = await Process.start(
        'sh',
        ['-c', command],
        runInShell: true,
      );

      process.stdout.transform(const Utf8Decoder()).listen((data) => stdoutData = data);

      process.stderr.transform(const Utf8Decoder()).listen((data) => stderrData = data);

      await process.exitCode;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void buildEmulater() {
    if (stdoutData == null) return;
    emulators = [];

    String emulator = stdoutData!.replaceAll('List of devices attached', '').trim();

    if (emulator != "") {
      emulators.add(emulatorsSelected);
      emulators.add(emulator);
    }
  }

  @override
  bool isRoot() {
    if (stdoutData == null) return false;

    return stdoutData!.trim() == "adbd is already running as root";
  }

  @override
  void buildProject() {
    if (stdoutData == null) return;
    projects = [];

    projects.add(projectSelected);
    List<String> list = stdoutData!.split('\n');

    projects.addAll(list);
  }

  @override
  void buildDatabase() {
    if (stdoutData == null) return;
    databases = [];

    databases.add(selectDatabase);
    List<String> list = stdoutData!.split('\n');

    databases.addAll(list);
  }

  @override
  void buildShared() {
    if (stdoutData == null) return;
    shareds = [];

    shareds.add(selectShared);
    List<String> list = stdoutData!.split('\n');

    shareds.addAll(list);
  }

  void reset() {
    stdoutData = null;
    stderrData = null;
    emulators = [];
    projects = [];
    databases = [];
    shareds = [];
  }
}
