import 'package:flutter/material.dart';
import '../models/game_state.dart';

class GameBoardPainter extends CustomPainter {
  final BackgroundType backgroundType;
  final List<int> platforms;
  final double platformSpacing;

  GameBoardPainter({
    required this.backgroundType,
    required this.platforms,
    this.platformSpacing = 100,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (backgroundType) {
      case BackgroundType.buildings:
        _drawBuildings(canvas, size);
        break;
      case BackgroundType.rocks:
        _drawRocks(canvas, size);
        break;
      case BackgroundType.mountains:
        _drawMountains(canvas, size);
        break;
      case BackgroundType.trees:
        _drawTrees(canvas, size);
        break;
    }
  }

  void _drawBuildings(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Sky gradient already handled by container
    
    // Draw city buildings in background
    final buildingColors = [
      Colors.grey.shade700,
      Colors.grey.shade600,
      Colors.grey.shade500,
      Colors.blueGrey.shade700,
    ];
    
    for (int i = 0; i < 5; i++) {
      final buildingWidth = 60.0 + (i % 3) * 20;
      final buildingHeight = 100.0 + (i % 4) * 50;
      final xPos = i * (size.width / 5);
      
      paint.color = buildingColors[i % buildingColors.length];
      canvas.drawRect(
        Rect.fromLTWH(
          xPos,
          size.height - buildingHeight,
          buildingWidth,
          buildingHeight,
        ),
        paint,
      );
      
      // Windows
      paint.color = Colors.yellow.shade200.withOpacity(0.7);
      for (int row = 0; row < (buildingHeight / 20).floor(); row++) {
        for (int col = 0; col < 3; col++) {
          canvas.drawRect(
            Rect.fromLTWH(
              xPos + 10 + col * 15,
              size.height - buildingHeight + 10 + row * 20,
              8,
              12,
            ),
            paint,
          );
        }
      }
    }
  }

  void _drawRocks(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Draw rock formations
    final rockColors = [
      Colors.brown.shade600,
      Colors.brown.shade700,
      Colors.grey.shade600,
    ];
    
    for (int i = 0; i < 4; i++) {
      paint.color = rockColors[i % rockColors.length];
      
      final path = Path();
      final xPos = i * (size.width / 4) + 20;
      final height = 80.0 + (i % 3) * 40;
      
      // Jagged rock shape
      path.moveTo(xPos, size.height);
      path.lineTo(xPos + 30, size.height - height);
      path.lineTo(xPos + 60, size.height - height + 20);
      path.lineTo(xPos + 80, size.height - height - 10);
      path.lineTo(xPos + 100, size.height);
      path.close();
      
      canvas.drawPath(path, paint);
      
      // Add shadow
      paint.color = Colors.black.withOpacity(0.2);
      canvas.drawPath(path, paint);
    }
  }

  void _drawMountains(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Background mountains
    paint.color = Colors.blueGrey.shade300;
    final bgPath = Path();
    bgPath.moveTo(0, size.height);
    bgPath.lineTo(size.width * 0.2, size.height * 0.4);
    bgPath.lineTo(size.width * 0.4, size.height * 0.6);
    bgPath.lineTo(size.width * 0.6, size.height * 0.3);
    bgPath.lineTo(size.width * 0.8, size.height * 0.5);
    bgPath.lineTo(size.width, size.height * 0.4);
    bgPath.lineTo(size.width, size.height);
    bgPath.close();
    canvas.drawPath(bgPath, paint);
    
    // Foreground mountains
    paint.color = Colors.blueGrey.shade600;
    final fgPath = Path();
    fgPath.moveTo(0, size.height);
    fgPath.lineTo(size.width * 0.25, size.height * 0.6);
    fgPath.lineTo(size.width * 0.5, size.height * 0.5);
    fgPath.lineTo(size.width * 0.75, size.height * 0.7);
    fgPath.lineTo(size.width, size.height * 0.6);
    fgPath.lineTo(size.width, size.height);
    fgPath.close();
    canvas.drawPath(fgPath, paint);
    
    // Snow caps
    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.6), 15, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 20, paint);
  }

  void _drawTrees(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Draw forest of trees
    for (int i = 0; i < 8; i++) {
      final xPos = i * (size.width / 8) + 20;
      final treeHeight = 80.0 + (i % 3) * 30;
      
      // Tree trunk
      paint.color = Colors.brown.shade700;
      canvas.drawRect(
        Rect.fromLTWH(
          xPos + 15,
          size.height - treeHeight * 0.4,
          15,
          treeHeight * 0.4,
        ),
        paint,
      );
      
      // Tree foliage (triangular)
      paint.color = Colors.green.shade700;
      final treePath = Path();
      treePath.moveTo(xPos, size.height - treeHeight * 0.4);
      treePath.lineTo(xPos + 22.5, size.height - treeHeight);
      treePath.lineTo(xPos + 45, size.height - treeHeight * 0.4);
      treePath.close();
      canvas.drawPath(treePath, paint);
      
      // Second layer
      paint.color = Colors.green.shade600;
      final treePath2 = Path();
      treePath2.moveTo(xPos + 5, size.height - treeHeight * 0.6);
      treePath2.lineTo(xPos + 22.5, size.height - treeHeight * 0.85);
      treePath2.lineTo(xPos + 40, size.height - treeHeight * 0.6);
      treePath2.close();
      canvas.drawPath(treePath2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PlatformWidget extends StatelessWidget {
  final int number;
  final bool isHighlighted;
  final double width;
  final double height;

  const PlatformWidget({
    super.key,
    required this.number,
    this.isHighlighted = false,
    this.width = 80,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isHighlighted
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.grey.shade400, Colors.grey.shade600],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted ? Colors.green.shade800 : Colors.grey.shade800,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
