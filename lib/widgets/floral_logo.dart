import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/app_colors.dart';

class FloralLogo extends StatelessWidget {
  const FloralLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.primary, // Uses theme primary color
            AppColors.lightPink, // Uses derived color
          ],
        ),
      ),
      child: CustomPaint(
        painter: FloralLogoPainter(context: context),
      ),
    );
  }
}

// Custom painter for floral logo - intricate floral/geometric pattern
class FloralLogoPainter extends CustomPainter {
  final BuildContext? context;
  
  FloralLogoPainter({this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;

    // Get primary color from context or fallback to AppColors
    final primaryColor = context != null 
        ? Theme.of(context!).colorScheme.primary 
        : AppColors.primary;

    // Outer petals/ribbons - creating intertwined effect
    final outerPaint = Paint()
      ..color = AppColors.logoDark
      ..style = PaintingStyle.fill;

    final innerPaint = Paint()
      ..color = primaryColor // Uses theme primary color
      ..style = PaintingStyle.fill;

    final lightPaint = Paint()
      ..color = AppColors.lightPink
      ..style = PaintingStyle.fill;

    // Draw 8 main petals arranged in a circle
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8;
      final x = center.dx + radius * 0.65 * math.cos(angle);
      final y = center.dy + radius * 0.65 * math.sin(angle);
      
      // Draw petal shape (oval)
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: radius * 0.5,
          height: radius * 0.35,
        ),
        outerPaint,
      );
      canvas.restore();
    }

    // Draw inner layer of smaller petals
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8 + math.pi / 8;
      final x = center.dx + radius * 0.4 * math.cos(angle);
      final y = center.dy + radius * 0.4 * math.sin(angle);
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: radius * 0.35,
          height: radius * 0.25,
        ),
        innerPaint,
      );
      canvas.restore();
    }

    // Center circle
    canvas.drawCircle(
      center,
      radius * 0.25,
      lightPaint,
    );

    // Add decorative strokes for ribbon effect
    final strokePaint = Paint()
      ..color = AppColors.logoLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 4; i++) {
      final angle = (i * math.pi * 2) / 4;
      final path = Path();
      path.moveTo(
        center.dx + radius * 0.3 * math.cos(angle),
        center.dy + radius * 0.3 * math.sin(angle),
      );
      path.lineTo(
        center.dx + radius * 0.7 * math.cos(angle),
        center.dy + radius * 0.7 * math.sin(angle),
      );
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

