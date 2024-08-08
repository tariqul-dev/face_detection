import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:face_detection/utils/face_painter.dart';
import 'package:face_detection/utils/counturs_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/camera/camera_bloc.dart';

void main() {
  runApp(const FaceDetectionApp());
}

class FaceDetectionApp extends StatelessWidget {
  const FaceDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CameraBloc>(create: (_) => CameraBloc()),
        ],
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CameraBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<CameraBloc>();
  }

  captureImage() async {
    XFile? imageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    bloc.add(CaptureImageEvent(imageFile));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face detector"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: BlocBuilder<CameraBloc, CameraState>(
              builder: (context, state) {
                if (state is GetImageState) {
                  // final facePainter = FacePainter( state.rectList,);
                  final imageSize = Size(
                    state.decodedImage.width!.toDouble(),
                    state.decodedImage.height!.toDouble(),
                  );



                  return Stack(
                     fit: StackFit.expand,
                     children: [
                       Image.file(state.image,
                       height: imageSize.height,
                         width: imageSize.width,
                         fit: BoxFit.contain,
                       ),
                       CustomPaint(
                         painter: ContourPainter(imageSize, state.rectList),

                       ),
                     ],

                   );

                  // FacePainter(image, state.faces);

                }

                return const SizedBox();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Text("data"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
