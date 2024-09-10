import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  IconWithLabel({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}