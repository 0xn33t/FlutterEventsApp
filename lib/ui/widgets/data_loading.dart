import 'package:flutter/material.dart';

class DataLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}