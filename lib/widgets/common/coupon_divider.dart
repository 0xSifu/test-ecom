import 'package:flutter/material.dart';
import 'package:ufo_elektronika/constants/colors.dart';
import 'dart:math' as math;

class CouponDivider extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final double circleRadius;
  final double borderWidth;
  final bool centerLine;

  const CouponDivider({
    super.key,
    this.color = Colors.white,
    this.borderColor = AppColor.grayBorder,
    this.circleRadius = 8,
    this.borderWidth = 1,
    this.centerLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        painter: Divider(
          color: color,
          borderColor: borderColor,
          circleRadius: circleRadius,
          borderWidth: borderWidth,
        ),
      ),
    );
  }
}

class Divider extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double circleRadius;
  final double borderWidth;
  final bool centerLine;

  Divider({
    this.color = Colors.white,
    this.borderColor = AppColor.grayBorder,
    this.circleRadius = 8,
    this.borderWidth = 1,
    this.centerLine = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    double borderCircleRadius = (circleRadius * 2) + borderWidth;

    // garis tengah
    if (centerLine) {
      paint.color = borderColor;
      canvas.drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), paint);
    }

    // border set lingkaran kiri
    paint.color = borderColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: const Offset(0, 0),
        height: borderCircleRadius,
        width: borderCircleRadius,
      ),
      -math.pi / 2, // Mulai dari sudut -90 derajat (menghadap ke kiri)
      math.pi, // Menggambar setengah lingkaran (180 derajat)
      false,
      paint,
    );
    // background set lingkaran kiri
    paint.color = color;
    canvas.drawCircle(Offset(0, size.height / 2), circleRadius - 0.4, paint);

    // border set lingkaran kanan
    paint.color = borderColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width, 0),
        height: borderCircleRadius,
        width: borderCircleRadius,
      ),
      math.pi / 2, // Mulai dari sudut 90 derajat (menghadap ke kanan)
      math.pi, // Menggambar setengah lingkaran (180 derajat)
      false,
      paint,
    );
    // background set lingkaran kanan
    paint.color = color;
    canvas.drawCircle(
        Offset(size.width, size.height / 2), circleRadius - 0.4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
