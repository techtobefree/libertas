import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final MaterialAccentColor borderColor;
  final double dimension;
  final String url;
  final double borderRadius;
  final String userId;

  const ProfilePicture(
    this.borderColor,
    this.dimension,
    this.url,
    this.userId, {
    this.borderRadius = 10,
  });

  void _handleTap() {
    print('Profile picture tapped');
    // Add your desired functionality here
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: dimension,
        height: dimension,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: Icon(
                Icons.error,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
