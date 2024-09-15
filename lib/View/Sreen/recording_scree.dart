import 'package:black_camera/View/Sreen/Controller/recording_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

class RecordingScree extends StatefulWidget {
  const RecordingScree({super.key});

  @override
  State<RecordingScree> createState() => _RecordingScreeState();
}

class _RecordingScreeState extends State<RecordingScree> {

  RecordingController recordingController=Get.find<RecordingController>();


  // CameraController? _controller;
  // List<CameraDescription>? cameras;
  // late CameraDescription firstCamera;

  @override
  void initState() {
    super.initState();
   recordingController. initializeCamera();
  }

  // Future<void> initializeCamera() async {
  //   cameras = await availableCameras();
  //   if (cameras != null && cameras!.isNotEmpty) {
  //     firstCamera = cameras!.first;
  //
  //     _controller = CameraController(
  //       firstCamera,
  //       ResolutionPreset.high,
  //     );
  //
  //     await _controller!.initialize();
  //     setState(() {}); // Trigger a rebuild after the camera is initialized
  //   }
  // }
  //
  // ///<=========================== This is for start recording ==================>
  //
  // Future<void> startVideoRecording() async {
  //   if (_controller == null || !_controller!.value.isInitialized) {
  //     return;
  //   }
  //
  //   final directory = await getApplicationDocumentsDirectory();
  //   final videoPath = join(directory.path, '${DateTime.now()}.mp4');
  //
  //   try {
  //     await _controller!.startVideoRecording();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  //
  // ///<======================= This is for stop recording ======================>
  // Future<void> stopVideoRecording() async {
  //   if (_controller == null || !_controller!.value.isRecordingVideo){
  //     return;
  //   }
  //
  //   try {
  //     final videoFile = await _controller!.stopVideoRecording();
  //     print('Video recorded to: ${videoFile.path}');
  //
  //     // Save the video to the gallery
  //     await GallerySaver.saveVideo(videoFile.path);
  //     print('Video saved to gallery');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    recordingController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: GetBuilder<RecordingController>(
        builder: (controller) {
          return GestureDetector(
            onTap: ()async{
                  if (await Vibration.hasVibrator() ?? false) {
                  Vibration.vibrate(duration: 100); // Vibrate for 100ms
                  } else {
                  // Optionally, show a message if the device doesn't support vibration
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                  content: Text('Vibration not supported on this device'),
                  ),
                  );
                  }

                  controller.startVideoRecording();

                },
            onDoubleTap: ()async{

                  if (await Vibration.hasVibrator() ?? false) {
                  Vibration.vibrate(duration: 100); // Vibrate for 100ms
                  } else {
                  // Optionally, show a message if the device doesn't support vibration
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                  content: Text('Vibration not supported on this device'),
                  ),
                  );
                  }
                  controller.  stopVideoRecording();

                },
            child: Stack(
                children: [
                  controller. controller == null || !controller.controller!.value.isInitialized
                      ? const Center(child: CircularProgressIndicator())
                      : CameraPreview(controller. controller!),
                       Container(
                      color: Colors.black,
                    ),
                ],
              ),
          );
        }
      ),

      // body:Container(
      //
      // color:Colors.black,
      // child:  _controller == null || !_controller!.value.isInitialized
      //     ? const Center(child: CircularProgressIndicator()) // Show a loading indicator until the camera is ready
      //     :
      //     GestureDetector(
      //       onTap: ()async{
      //         if (await Vibration.hasVibrator() ?? false) {
      //         Vibration.vibrate(duration: 100); // Vibrate for 100ms
      //         } else {
      //         // Optionally, show a message if the device doesn't support vibration
      //         ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //         content: Text('Vibration not supported on this device'),
      //         ),
      //         );
      //         }
      //
      //         startVideoRecording();
      //
      //       },
      //       onDoubleTap: ()async{
      //
      //         if (await Vibration.hasVibrator() ?? false) {
      //         Vibration.vibrate(duration: 100); // Vibrate for 100ms
      //         } else {
      //         // Optionally, show a message if the device doesn't support vibration
      //         ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //         content: Text('Vibration not supported on this device'),
      //         ),
      //         );
      //         }
      //
      //
      //         stopVideoRecording();
      //
      //       },
      //       child: Container(
      //       color:Colors.black,
      //       child: CameraPreview(_controller!)),
      //     ),
      // )
    );
  }
}
