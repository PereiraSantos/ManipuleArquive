abstract class BuildCommandFactory {
  Future<List<String>> build(String platform);
  String get title;
  void select(String? value);
}
