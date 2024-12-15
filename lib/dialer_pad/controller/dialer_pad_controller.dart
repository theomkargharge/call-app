import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialerPadController extends GetxController {
  var dialedNumber = "".obs;

  void onNumberPressed(
    String number,
  ) {
    if (dialedNumber.value.length <= 10) {
      dialedNumber.value += number;
      update();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('You have reach the limit.!')),
      );
    }
  }

  void onBackspacePressed() {
    if (dialedNumber.isNotEmpty) {
      dialedNumber.value =
          dialedNumber.value.substring(0, dialedNumber.value.length - 1);
      update();
    }
  }

  void onCallPressed() {
    if (dialedNumber.isNotEmpty) {
      DirectCaller().makePhoneCall(dialedNumber.value);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Calling ${dialedNumber.value}...')),
      );
      dialedNumber.value = "";
      Navigator.of(Get.context!).pop();
    }
  }


  Widget buildDialButton(String label, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
