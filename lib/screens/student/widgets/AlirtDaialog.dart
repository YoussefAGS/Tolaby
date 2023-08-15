import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  String alertTitle = '';
  String alertContent = '';
  VoidCallback onPrssedNo;
  VoidCallback onPrssedYes;

  AlertDialogComponent(
      {super.key, required this.alertTitle,
        required this.alertContent,
        required this.onPrssedNo,
        required this.onPrssedYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$alertTitle ',
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      content: Text(
        'Are You Sure $alertContent ?!',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))),
            onPressed: onPrssedYes,
            child: const Text(
              'Yes',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
        const SizedBox(
          width: 20,
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))),
            onPressed: onPrssedNo,
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
      ],
    );
  }
}
