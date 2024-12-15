import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;

  void animationFunction() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      animationBehavior: AnimationBehavior.preserve,
    );
    animationController?.addListener(() {
      if (animationController!.isCompleted) {
        animationController?.repeat();
      }
    });
    animationController?.forward();
  }

  var listRadius = [200, 250, 300, 350, 400];

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    animationController?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationFunction();
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/navbar');
    });
  }
}
