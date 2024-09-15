
import 'package:black_camera/View/Sreen/Controller/recording_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DependancyInjection extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => RecordingController(), fenix: true);
  }
}
