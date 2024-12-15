import 'package:call_app/dialer_pad/controller/dialer_pad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialerPad extends StatelessWidget {
  const DialerPad({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialerPadController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Display the entered number
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    controller.dialedNumber.value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Dial pad
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var i = 1; i <= 9; i++)
                      controller.buildDialButton(
                        i.toString(),
                        onPressed: () => controller.onNumberPressed(
                          i.toString(),
                        ),
                      ),
                    controller.buildDialButton(
                      '*',
                      onPressed: () => controller.onNumberPressed(
                        '*',
                      ),
                    ),
                    controller.buildDialButton(
                      '0',
                      onPressed: () => controller.onNumberPressed(
                        '0',
                      ),
                    ),
                    controller.buildDialButton(
                      '#',
                      onPressed: () => controller.onNumberPressed(
                        '#',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Backspace and Call buttons
                Row(
                  children: [
                    // Backspace button
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: IconButton(
                        onPressed: controller.onBackspacePressed,
                        icon: const Icon(
                          Icons.backspace,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // Call button
                    ElevatedButton(
                      onPressed: controller.onCallPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        child: const Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
