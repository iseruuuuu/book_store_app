import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    required this.isSelected,
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final Widget image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.red : Colors.transparent,
        child: image,
      ),
    );
  }
}
