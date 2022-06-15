import 'package:flutter/material.dart';

class EmptySearchScreen extends StatelessWidget {
  const EmptySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '検索結果がありません',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
