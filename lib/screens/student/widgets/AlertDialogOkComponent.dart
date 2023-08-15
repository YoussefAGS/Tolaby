import 'package:flutter/material.dart';

class AlertDialogOkComponent extends StatelessWidget {
  String alertTitle = '';
  String alertContent = '';

  AlertDialogOkComponent(
      {super.key, required this.alertTitle,
        required this.alertContent,
      });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.dangerous,color: Colors.red,size: 28,),
          const SizedBox(width: 4,),
          Text(
            '$alertTitle ',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: Text(
        '$alertContent ',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))),
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
      ],
    );
  }
}
