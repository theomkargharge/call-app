import 'package:call_app/incoming_call/incoming_call.dart';
import 'package:call_app/navbar/nav_bar.dart';
import 'package:call_app/splash_screen/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Scaffold(
          body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller.animationController!,
              builder: (context, child) {
                return CustomPaint(
                  painter: CirclePainter(
                    progress: controller.animationController!.value,
                    listRadius: controller.listRadius,
                  ),
                );
              },
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.call,
              size: 55,
              color: Colors.orange,
            ),
          )
        ],
      ));
    });
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final List<int> listRadius;

  CirclePainter({required this.progress, required this.listRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 200.0;

    // Draw circles with different radii.
    for (final radius in listRadius) {
      final animatedRadius = radius + (radius * progress);
      canvas.drawCircle(size.center(Offset.zero), animatedRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
