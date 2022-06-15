import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: const [
          Text(
            '削除確認',
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      content: const Text(
        '削除してもよろしいですか？',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        Builder(builder: (context) {
          return TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'キャンセル',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          );
        }),
        Builder(
          builder: (context) {
            return TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
