import 'package:flutter/material.dart';

class UiMessage extends StatelessWidget {
  final String message;
  final Color? messageColor;
  final double? messageSize;

  UiMessage({
    required this.message,
    this.messageColor,
    this.messageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: messageColor ?? Colors.red,
          fontSize: messageSize ?? 13,
        ),
      ),
    );
  }
}
