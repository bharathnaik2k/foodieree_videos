import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.location_on_rounded,
        size: 45,
      ),
    );
  }
}
