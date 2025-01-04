import 'package:flutter/material.dart';

class PermissionModal extends StatelessWidget {
  final String title;
  final String content;

  const PermissionModal({
    Key? key,
    this.title = "Permissions Required",
    this.content =
        "To provide the best experience, we need access to your location, notifications, and other settings. "
        "Please grant these permissions to continue.",
  }) : super(key: key);

 static Future<bool> show(BuildContext context,
    {String? title, String? content}) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PermissionModal(
            title: title ?? "Permissions Required",
            content: content ??
                "To provide the best experience, we need access to permissions.",
          );
        },
      ) ??
      false; 
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
 title: Center(
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  content: SingleChildScrollView(
    child: Text(
      content,
      // textAlign: TextAlign.center, 
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  ),
  actions: [
    TextButton(
      onPressed: () {
        Navigator.of(context).pop(false);
      },
      child: Text("Cancel"),
    ),
    TextButton(
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      child: Text("Proceed"),
    ),
  ],
);
  }
}
