import 'package:call_e_log/call_log.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreenController extends GetxController with WidgetsBindingObserver {
  var isLoadingMore = false.obs;
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();

    if (isPermissionGranted.value) {
      fetchCallLogs();
      update();
    } else {
      await requestCallLogPermission().then((granted) {
        if (granted) {
          isPermissionGranted.value = true;
          update();

          fetchCallLogs();
        } else {
          isPermissionGranted.value = false;
          update();
        }
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<bool> requestCallLogPermission() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    } else if (status.isDenied) {
      status = await Permission.phone.request();
    }
    return status.isGranted;
  }

  var isPermissionGranted = false.obs;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed &&
        isPermissionGranted.value == false) {
      await requestCallLogPermission().then((granted) {
        if (granted) {
          isPermissionGranted.value = true;
          update();

          fetchCallLogs();
        } else {
          isPermissionGranted.value = false;
          update();
        }
      });
    } else if (state == AppLifecycleState.resumed &&
        isPermissionGranted.value) {
      fetchCallLogs();
    }
    super.didChangeAppLifecycleState(state);
  }

  late Iterable<CallLogEntry> entries = <CallLogEntry>[].obs;

  var isLoading = false.obs;
  void fetchCallLogs() async {
    // Ensure permissions
    isLoading.value = true;
    update();

    try {
      if (await requestCallLogPermission()) {

        entries = await CallLog.get();

        update();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Permission not granted.!'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Something went wrong.!'),
        ),
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  String formatTimestamp(DateTime timestamp) {
    DateTime now = DateTime.now();

    // Check if the timestamp is from today
    bool isToday = now.day == timestamp.day &&
        now.month == timestamp.month &&
        now.year == timestamp.year;

    if (isToday) {
      Duration difference = now.difference(timestamp);

      // If the timestamp is less than an hour ago, show "X minutes ago"
      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else {
        // Otherwise, show the time in "hh:mm a" format
        return DateFormat('hh:mm a').format(timestamp); // e.g., "12:27 PM"
      }
    }

    // Check if the timestamp is within the current week
    DateTime startOfWeek =
        now.subtract(Duration(days: now.weekday - 1)); // Monday
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

    if (timestamp.isAfter(startOfWeek) && timestamp.isBefore(endOfWeek)) {
      // If the timestamp is within the current week, show the day and time
      return DateFormat('EEEE, hh:mm a')
          .format(timestamp); // e.g., "Monday, 10:30 AM"
    }

    // For older timestamps, show the full date and time
    return DateFormat('dd MMM yyyy : hh:mm a')
        .format(timestamp); // e.g., "12 Dec 2023 : 12:30 AM"
  }

  final DirectCaller directCaller = DirectCaller();
}
