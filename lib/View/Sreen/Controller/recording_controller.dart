import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RecordingController extends GetxController{

  CameraController? controller;
  List<CameraDescription>? cameras;
  late CameraDescription firstCamera;


  ///<===================== This is for initialize camera ====================>

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      firstCamera = cameras!.first;

      controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      await controller!.initialize();

      update();
      //setState(() {}); // Trigger a rebuild after the camera is initialized
    }
  }


///<========================= This is for start recording ====================>
  Future<void> startVideoRecording() async {
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final videoPath = join(directory.path, '${DateTime.now()}.mp4');

    try {
      await controller!.startVideoRecording();
    } catch (e) {
      print(e);
    }
  }


  ///<======================= This is for stop recording ======================>
  Future<void> stopVideoRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo){
      return;
    }

    try {
      final videoFile = await controller!.stopVideoRecording();
      print('Video recorded to: ${videoFile.path}');

      // Save the video to the gallery
      await GallerySaver.saveVideo(videoFile.path);
      print('Video saved to gallery');
    } catch (e) {
      print(e);
    }
  }


}