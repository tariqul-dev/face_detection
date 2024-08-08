import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

part 'camera_event.dart';

part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<CameraEvent>((event, emit) {});

    on<CaptureImageEvent>(
      (event, emit) async{
        if (event.image != null) {

          final rectList = await doFaceDetect(event.image!);
          final image = File(event.image!.path);
          var decodedImage = await decodeImageFromList(image.readAsBytesSync());

          emit(GetImageState(image, decodedImage, rectList));
        }
        else {
          print("Image not found");
        }
      },
    );
  }
}

Future<List<Face>> doFaceDetect(XFile image) async {
  final InputImage inputImage = InputImage.fromFilePath(image.path);
  final options = FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    enableClassification: true,
    enableTracking: true,
    enableContours: true,
    enableLandmarks: true,
  );

  final faceDetector = FaceDetector(options: options);


  final List<Face> faces = await faceDetector.processImage(inputImage);

  List<Rect> rectList = [];

  for (Face face in faces) {
    face.contours;
    final Rect boundingBox = face.boundingBox;
    rectList.add(boundingBox);
    print("image rect: ${boundingBox.toString()}");
  }

  return faces;
}