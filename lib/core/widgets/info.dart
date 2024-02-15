import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.input1, required this.input2});
  final String input1;
  final String input2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          input1,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          input2,
        ),
      ],
    );
  }
}
