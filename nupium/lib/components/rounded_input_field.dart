import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final double borderRadius;
  final TextEditingController? controller;
  final IconButton? suffixIcon;

  const RoundedInputField({
    Key? key,
    required this.labelText,
    required this.obscureText,
    this.borderRadius = 10.0,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                contentPadding: const EdgeInsets.all(16.0),
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
