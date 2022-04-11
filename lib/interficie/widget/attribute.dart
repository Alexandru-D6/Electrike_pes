import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Attribute extends StatelessWidget {
  const Attribute({
    Key? key,
    required this.name,
    required this.value,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String name, value;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}