import 'package:flutter/material.dart';

class BorderItem {
  static Border borderFirst() {
    return const Border(
      top: BorderSide(
        color: Colors.black,
        width: 3,
      ),
      bottom: BorderSide(
        color: Colors.black,
        width: 3,
      ),
    );
  }

  static Border borderOther() {
    return const Border(
      top: BorderSide(
        color: Colors.black,
        width: 0,
      ),
      bottom: BorderSide(
        color: Colors.black,
        width: 3,
      ),
    );
  }
}
