import 'dart:io';
import 'dart:ui';

double translateX(
    double x,
    Size canvasSize,
    Size imageSize,
    ) {
  return x *
      canvasSize.width /
      (Platform.isIOS ? imageSize.width : imageSize.height);
}

double translateY(
    double y,
    Size canvasSize,
    Size imageSize,
    ) {
  return y *
      canvasSize.height /
      (Platform.isIOS ? imageSize.height : imageSize.width);
}
