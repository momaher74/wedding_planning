import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class BrideGroomIllustration extends StatelessWidget {
  const BrideGroomIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background columns
          CustomPaint(
            size: Size.infinite,
            painter: ColumnsBackgroundPainter(),
          ),
          // Bride and Groom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Groom
              _buildGroom(),
              const SizedBox(width: 40),
              // Hearts
              Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary, size: 16),
                    const SizedBox(height: 4),
                    Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Bride
              _buildBride(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroom() {
    return Stack(
      children: [
        Column(
          children: [
            // Head
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.skinTone, // Skin tone
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            // Body (suit)
            Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.darkSuit, // Dark suit
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Shirt and tie
                  Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Container(
                        width: 4,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.darkBrown, // Tie color
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Hand on hip (left side)
        Positioned(
          left: -8,
          top: 40,
          child: Container(
            width: 12,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.skinTone,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBride() {
    return Column(
      children: [
        // Head
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.skinTone, // Skin tone
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        // Body (wedding dress)
        Container(
          width: 50,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Bouquet
              Builder(
                builder: (context) => Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary, // Uses theme primary color
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_florist,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for columns background
class ColumnsBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.columnsBg
      ..style = PaintingStyle.fill;

    final columnWidth = size.width / 5;
    final columnHeight = size.height * 0.8;

    // Draw columns
    for (int i = 0; i < 5; i++) {
      final x = i * columnWidth + columnWidth / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(x, size.height / 2),
            width: columnWidth * 0.3,
            height: columnHeight,
          ),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

