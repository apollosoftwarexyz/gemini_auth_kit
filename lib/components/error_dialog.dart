import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String message) =>
    showGeneralDialog(
      context: context,
      barrierLabel: 'GeminiErrorDialog',
      barrierDismissible: true,
      pageBuilder: (context, _, __) {
        return ErrorDialog(message: message);
      },
    );

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.red,
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ERROR',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
