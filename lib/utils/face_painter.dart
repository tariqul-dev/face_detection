import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {

  List<Rect> rectList = [];

  FacePainter(this.rectList);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Rect rect = Rect.fromLTRB(275.0, 578.0, 354.0, 681.0);
    // canvas.drawRect(rect, paint);


    for(Rect rect in rectList){
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) => true;
}
