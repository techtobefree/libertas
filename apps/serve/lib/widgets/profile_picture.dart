import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serve_to_be_free/repository/repository.dart';

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
    super.key,
    this.borderRadius = 10,
  });

  //void _handleTap() {
  //  // Add your desired functionality here
  //}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.pushNamed("profile", queryParameters: {'id': userId}),
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
        child: repo.image(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: const Icon(
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
