part of 'camera_bloc.dart';

sealed class CameraState extends Equatable {
  const CameraState();
}

final class CameraInitial extends CameraState {
  @override
  List<Object> get props => [];
}

final class GetImageState extends CameraState {
  final File image;
  final List<Face> faces;
  final  decodedImage;


  const GetImageState(this.image, this.decodedImage, this.faces);

  @override
  List<Object?> get props => [image, faces, decodedImage];
}
