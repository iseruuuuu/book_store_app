import 'package:flutter/material.dart';

class EmptyCardScreen extends StatelessWidget {
  const EmptyCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 40,
                ),
                Text(
                  'で値段を追加しよう',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}
