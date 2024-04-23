import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;

  RoundedImage({required this.imageUrl, this.borderRadius = 12.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        // You can add width and height constraints as needed
        width: 40,
        height: 40,
      ),
    );
  }
}
