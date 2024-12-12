import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    required this.rating,
    this.size = 14,
  });

  /// rating 1 - 5
  final double rating;

  /// icon size
  final double size;

  @override
  Widget build(BuildContext context) {
    double currentRating = rating;
    List<Widget> stars = [];
    for (int i = 1; i < 6; i++) {
      if (currentRating > i || currentRating > 0.5) {
        stars.insert(
          i - 1,
          Icon(
            Icons.star,
            size: size,
            color: Colors.amber,
          ),
        );
      } else if (currentRating > 0 && currentRating <= 0.5) {
        stars.insert(
          i - 1,
          Icon(
            Icons.star_half,
            size: size,
            color: Colors.amber,
          ),
        );
      } else {
        stars.insert(
          i - 1,
          Icon(
            Icons.star_outline,
            size: size,
            color: Colors.amber,
          ),
        );
      }

      currentRating = currentRating < 1 ? 0 : currentRating - 1;
    }

    return Row(
      children: stars,
    );
  }
}
