import 'package:flutter/material.dart';

class RoundedBannerImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;

  const RoundedBannerImage({super.key, 
    required this.imageUrl,
    this.borderRadius = 16.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity, // Adjust as needed
          height: 200, // Adjust as needed
        ),
      ),
    );
  }
}

// Example Usage
