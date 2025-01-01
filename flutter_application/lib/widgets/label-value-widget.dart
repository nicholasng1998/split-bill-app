import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isPassword;
  final bool isEditable;
  final TextEditingController? controller;

  LabelValueWidget({
    required this.label,
    required this.value,
    this.isPassword = false,
    this.isEditable = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          isEditable
              ? Container(
                  width: 200.0,
                  child: TextField(
                    controller: controller,
                    obscureText: isPassword, // Hide text for password
                    decoration: InputDecoration(
                      hintText: 'Enter your $label',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    ),
                  ),
                )
              : Text(
                  isPassword ? '*' * value.length : value,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
    );
  }
}
