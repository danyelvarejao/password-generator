import 'package:flutter/material.dart';

class StrengthSquare extends StatelessWidget {
  const StrengthSquare({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 10,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          border: color == null ? Border.all(color: Colors.white, width: 2.0) : null,
        ),
      ),
    );
  }
}
