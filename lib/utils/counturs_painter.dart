import 'package:face_detection/utils/coordinates_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ContourPainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;

  ContourPainter(this.imageSize, this.faces);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var face in faces) {
      // Rect rect = Rect.fromLTRB(
      //   face.boundingBox.left * scaleX,
      //   face.boundingBox.top * scaleY,
      //   face.boundingBox.right * scaleX,
      //   face.boundingBox.bottom * scaleY,
      // );

      final left = translateX(face.boundingBox.left, size, imageSize);
      final top = translateX(face.boundingBox.top, size, imageSize);
      final right = translateX(face.boundingBox.right, size, imageSize);
      final bottom = translateX(face.boundingBox.bottom, size, imageSize);

      Rect rect = Rect.fromLTRB(left, top, right, bottom);

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
