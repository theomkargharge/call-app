import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactScreenController extends GetxController
    with WidgetsBindingObserver {
  @override
  void onInit() {
    // TODO: implement onInit
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Contact> contacts = [];
  var isLoading = false.obs;

  var isRequestingPermission = false.obs;

  void fetchContacts() async {
    isLoading.value = true;
    try {
      if (isRequestingPermission == true) {
        // Fetch contacts with properties
        contacts = await FlutterContacts.getContacts(
          withPhoto: true,
          sorted: true,
          withProperties: true,
          withThumbnail: true,
        );
      } else {}
    } catch (e) {
    } finally {
      isLoading.value = false;
      update();
    }
  }

  var isNotGranted = false;

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();

    await FlutterContacts.requestPermission().then((value) {
      if (value) {
        isRequestingPermission.value = true;
        update();
        fetchContacts();
      } else {
        isRequestingPermission.value = false;
        update();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && isRequestingPermission == false) {
      await FlutterContacts.requestPermission().then((granted) {
        if (granted) {
          isRequestingPermission.value = true;
          fetchContacts();
        } else {
          isRequestingPermission.value = false;
          update();
        }
      });
    }
  }

  var isCalling = false.obs;
}
