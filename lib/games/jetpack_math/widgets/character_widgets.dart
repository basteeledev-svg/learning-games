import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimalCharacter extends StatelessWidget {
  final double size;
  final AnimalType type;

  const AnimalCharacter({
    super.key,
    this.size = 60,
    this.type = AnimalType.cat,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _AnimalPainter(type),
    );
  }
}

enum AnimalType {
  cat,
  dog,
  rabbit,
  bear,
  fox;

  static AnimalType random() {
    return AnimalType.values[math.Random().nextInt(AnimalType.values.length)];
  }
}

class _AnimalPainter extends CustomPainter {
  final AnimalType type;

  _AnimalPainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case AnimalType.cat:
        _drawCat(canvas, size);
        break;
      case AnimalType.dog:
        _drawDog(canvas, size);
        break;
      case AnimalType.rabbit:
        _drawRabbit(canvas, size);
        break;
      case AnimalType.bear:
        _drawBear(canvas, size);
        break;
      case AnimalType.fox:
        _drawFox(canvas, size);
        break;
    }
  }

  void _drawCat(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Body (orange)
    paint.color = Colors.orange.shade700;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.65),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );
    
    // Head
    paint.color = Colors.orange.shade600;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.3,
      paint,
    );
    
    // Ears
    final earPath = Path();
    // Left ear
    earPath.moveTo(size.width * 0.3, size.height * 0.25);
    earPath.lineTo(size.width * 0.25, size.height * 0.1);
    earPath.lineTo(size.width * 0.4, size.height * 0.2);
    earPath.close();
    // Right ear
    earPath.moveTo(size.width * 0.7, size.height * 0.25);
    earPath.lineTo(size.width * 0.75, size.height * 0.1);
    earPath.lineTo(size.width * 0.6, size.height * 0.2);
    earPath.close();
    canvas.drawPath(earPath, paint);
    
    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.08, paint);
    
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.04, paint);
    
    // Nose
    paint.color = Colors.pink;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.05, paint);
    
    // Whiskers
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawLine(Offset(size.width * 0.2, size.height * 0.38), Offset(size.width * 0.35, size.height * 0.4), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.38), Offset(size.width * 0.65, size.height * 0.4), paint);
  }

  void _drawDog(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Body (brown)
    paint.color = Colors.brown.shade600;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.65),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );
    
    // Head
    paint.color = Colors.brown.shade500;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.3,
      paint,
    );
    
    // Floppy ears
    paint.color = Colors.brown.shade700;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.25, size.height * 0.35),
        width: size.width * 0.15,
        height: size.height * 0.25,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.75, size.height * 0.35),
        width: size.width * 0.15,
        height: size.height * 0.25,
      ),
      paint,
    );
    
    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.08, paint);
    
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.04, paint);
    
    // Snout
    paint.color = Colors.brown.shade400;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.42),
        width: size.width * 0.25,
        height: size.height * 0.15,
      ),
      paint,
    );
    
    // Nose
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.42), size.width * 0.06, paint);
  }

  void _drawRabbit(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Body (white/gray)
    paint.color = Colors.grey.shade300;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.65),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );
    
    // Head
    paint.color = Colors.grey.shade200;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.3,
      paint,
    );
    
    // Long ears
    paint.color = Colors.grey.shade300;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.15),
        width: size.width * 0.12,
        height: size.height * 0.3,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.15),
        width: size.width * 0.12,
        height: size.height * 0.3,
      ),
      paint,
    );
    
    // Inner ears (pink)
    paint.color = Colors.pink.shade100;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.15),
        width: size.width * 0.06,
        height: size.height * 0.2,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.15),
        width: size.width * 0.06,
        height: size.height * 0.2,
      ),
      paint,
    );
    
    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.08, paint);
    
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.04, paint);
    
    // Nose
    paint.color = Colors.pink;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.04, paint);
    
    // Whiskers
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawLine(Offset(size.width * 0.2, size.height * 0.38), Offset(size.width * 0.35, size.height * 0.4), paint);
    canvas.drawLine(Offset(size.width * 0.8, size.height * 0.38), Offset(size.width * 0.65, size.height * 0.4), paint);
  }

  void _drawBear(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Body (brown)
    paint.color = Colors.brown.shade800;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.65),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );
    
    // Head
    paint.color = Colors.brown.shade700;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.3,
      paint,
    );
    
    // Round ears
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.2), size.width * 0.1, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), size.width * 0.1, paint);
    
    // Inner ears
    paint.color = Colors.brown.shade600;
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.2), size.width * 0.05, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), size.width * 0.05, paint);
    
    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.08, paint);
    
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.04, paint);
    
    // Snout
    paint.color = Colors.brown.shade500;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.42),
        width: size.width * 0.2,
        height: size.height * 0.12,
      ),
      paint,
    );
    
    // Nose
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.42), size.width * 0.05, paint);
  }

  void _drawFox(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Body (orange)
    paint.color = Colors.deepOrange.shade700;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.65),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );
    
    // Head
    paint.color = Colors.deepOrange.shade600;
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.3,
      paint,
    );
    
    // Pointy ears
    final earPath = Path();
    // Left ear
    earPath.moveTo(size.width * 0.3, size.height * 0.25);
    earPath.lineTo(size.width * 0.25, size.height * 0.08);
    earPath.lineTo(size.width * 0.4, size.height * 0.2);
    earPath.close();
    // Right ear
    earPath.moveTo(size.width * 0.7, size.height * 0.25);
    earPath.lineTo(size.width * 0.75, size.height * 0.08);
    earPath.lineTo(size.width * 0.6, size.height * 0.2);
    earPath.close();
    canvas.drawPath(earPath, paint);
    
    // White face patch
    paint.color = Colors.white;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.38),
        width: size.width * 0.35,
        height: size.height * 0.2,
      ),
      paint,
    );
    
    // Eyes
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.08, paint);
    
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.32), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.32), size.width * 0.04, paint);
    
    // Nose
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), size.width * 0.045, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class JetpackWidget extends StatelessWidget {
  final double size;

  const JetpackWidget({
    super.key,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 1.2),
      painter: _JetpackPainter(),
    );
  }
}

class _JetpackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Main body (metallic gray)
    paint.color = Colors.grey.shade600;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height * 0.4),
          width: size.width * 0.7,
          height: size.height * 0.5,
        ),
        const Radius.circular(8),
      ),
      paint,
    );
    
    // Straps
    paint.color = Colors.brown.shade700;
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.2),
      Offset(size.width * 0.35, size.height * 0.6),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.2),
      Offset(size.width * 0.65, size.height * 0.6),
      paint,
    );
    
    // Thrusters (blue flames when active)
    paint.style = PaintingStyle.fill;
    paint.color = Colors.red.shade700;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.7),
        width: size.width * 0.2,
        height: size.height * 0.15,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.7),
        width: size.width * 0.2,
        height: size.height * 0.15,
      ),
      paint,
    );
    
    // Highlights
    paint.color = Colors.white.withOpacity(0.3);
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.25, size.width * 0.2, size.height * 0.1),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
