import 'dart:io';
import 'package:file_picker/file_picker.dart';

abstract class DirectoryPathFactory {
  Future<String> getPath();
}

class ArquivoPath implements DirectoryPathFactory {
  @override
  Future<String> getPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file.path;
    }

    return '';
  }
}

class FolderPath implements DirectoryPathFactory {
  @override
  Future<String> getPath() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) return selectedDirectory;
    return '';
  }
}
