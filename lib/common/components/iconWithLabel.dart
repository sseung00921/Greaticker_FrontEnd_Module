import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;

  IconWithLabel({
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.blue : Colors.black, fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}