class ButtonDropDownCache {
  static final ButtonDropDownCache _singleton = ButtonDropDownCache._internal();

  factory ButtonDropDownCache() {
    return _singleton;
  }

  ButtonDropDownCache._internal();

  String? _project;
  String? _emulator;
  String? _database;
  String? _shared;

  String? get project => _project;
  set setProject(String? value) => _project = value;

  String? get emulator => _emulator;
  set setEmulator(String? value) => _emulator = value;

  String? get database => _database;
  set setDatabase(String? value) => _database = value;

  String? get shared => _shared;
  set setShared(String? value) => _shared = value;
}
