import 'package:flutter/widgets.dart';
import 'package:manipule_arquive/widgets/elevated_button_widget.dart';
import 'package:manipule_arquive/widgets/directory_path/directory_path_factory.dart';

class DirectoryPath extends StatefulWidget {
  const DirectoryPath({
    super.key,
    required this.label,
    required this.title,
    required this.directoryPathFactory,
    required this.onClick,
  });

  final String label;
  final String title;
  final DirectoryPathFactory directoryPathFactory;
  final Function(String) onClick;

  @override
  State<DirectoryPath> createState() => _DirectoryPathState();
}

class _DirectoryPathState extends State<DirectoryPath> {
  String path = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButtonWidget(
          onPressed: () async {
            path = await widget.directoryPathFactory.getPath();
            widget.onClick(path);
            setState(() {});
          },
          label: widget.label,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text('${widget.title}: $path'),
        ),
      ],
    );
  }
}
