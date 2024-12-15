import 'dart:developer';

import 'package:call_app/contacts_screen/controller/contact_screen_controller.dart';
import 'package:call_app/simmer_effect/simmer_effect.dart';
import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsScreen extends StatelessWidget {
  ContactsScreen({super.key});

  final ContactScreenController controller = Get.put(ContactScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactScreenController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text(
            'Contacts',
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: controller.isRequestingPermission.value == false
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Permission is not granted, to avoid problem, Please give the permission',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        openAppSettings();
                      },
                      child: Text(
                        'Go To Setting',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            : ListView(
                children: [
                  controller.isLoading.value == true
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SimmerLoader(),
                            );
                          })
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          padding: EdgeInsets.all(20),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.contacts.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var contactData =
                                controller.contacts.elementAt(index);
                            var imageBytes = contactData.photoOrThumbnail;

                            return Card(
                              color: Colors.white,
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orangeAccent,
                                  radius: 20,
                                  backgroundImage: imageBytes != null
                                      ? MemoryImage(
                                          imageBytes) // Use MemoryImage for Uint8List
                                      : const AssetImage('assets/boy.png'),
                                ),
                                title: Text(
                                  contactData.name.first,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                trailing: IconButton(
                                    onPressed: () async {
                                      try {
                                        if (contactData.phones.isNotEmpty) {
                                          DirectCaller().makePhoneCall(
                                              contactData.phones.first.number);
                                        } else {
                                          log("No phone number available for this contact");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "No phone number available")),
                                          );
                                        }
                                      } catch (e) {
                                        log("Error during call: $e");
                                      }
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
                                      child: const Icon(
                                        Icons.call,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            );
                          })
                ],
              ),
      );
    });
  }
}
