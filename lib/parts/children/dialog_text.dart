import 'package:flutter/material.dart';

class DialogText extends StatelessWidget {
  final String title;
  final String subTitle;
  Color? textColor;

  DialogText({
    Key? key,
    required this.title,
    required this.subTitle,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
