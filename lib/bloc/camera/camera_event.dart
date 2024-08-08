part of 'camera_bloc.dart';

sealed class CameraEvent extends Equatable {
  const CameraEvent();
}

class CaptureImageEvent extends CameraEvent {
  final XFile? image;

  const CaptureImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}
