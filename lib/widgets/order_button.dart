import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  final VoidCallback onPressed;
  const OrderButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.restaurant, color: Colors.white),
      label: const Text(
        'Crave & Order',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
