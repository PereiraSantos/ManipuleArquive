import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

abstract class CommandFactory {
  Future<void> processStart(String command);
  List<String> buildEmulater();
  List<String> buildProject();
  List<String> buildDatabase();
  List<String> buildShared();
  bool isRoot();
}

class Command implements CommandFactory {
  String? stdoutData;
  String? stderrData;

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
  List<String> buildEmulater() {
    if (stdoutData == null) return [];

    List<String> emulators = [];

    String emulator = stdoutData!.replaceAll('List of devices attached', '').trim();

    if (emulator != "") {
      emulators.add('Selecione o emulador');
      emulators.add(emulator);
    }

    return emulators;
  }

  @override
  bool isRoot() {
    if (stdoutData == null) return false;

    return stdoutData!.trim() == "adbd is already running as root";
  }

  @override
  List<String> buildProject() {
    if (stdoutData == null) return [];
    List<String> projects = [];

    projects.add('Selecione o projeto');
    List<String> list = stdoutData!.split('\n');

    projects.addAll(list);

    return projects;
  }

  @override
  List<String> buildDatabase() {
    if (stdoutData == null) return [];
    List<String> databases = [];

    databases.add('Selecione o banco');
    List<String> list = stdoutData!.split('\n');

    databases.addAll(list);

    return databases;
  }

  @override
  List<String> buildShared() {
    if (stdoutData == null) return [];
    List<String> shareds = [];

    shareds.add('Selecione o shared');
    List<String> list = stdoutData!.split('\n');

    shareds.addAll(list);
    return shareds;
  }

  void reset() {
    stdoutData = null;
    stderrData = null;
  }
}
