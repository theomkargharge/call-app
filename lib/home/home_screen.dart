import 'package:call_app/home/controller/home_screen_controller.dart';
import 'package:call_app/simmer_effect/simmer_effect.dart';
import 'package:call_e_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: Text(
            'History',
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: controller.isPermissionGranted.value == false
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
                      onPressed: () {
                        openAppSettings();
                      },
                      child: Text('Go To Setting'),
                    )
                  ],
                ),
              )
            : Obx(
                () => ListView(
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
                              return const Divider(
                                thickness: 2,
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemCount: controller.entries.length < 100
                                ? controller.entries.length
                                : 100,
                            itemBuilder: (context, index) {
                              var callog = controller.entries.elementAt(index);
                              DateTime timestamp =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      callog.timestamp ?? 0);
                              return Card(
                                color: Colors.white,
                                elevation: 10,
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.orange,
                                    backgroundImage:
                                        AssetImage('assets/boy.png'),
                                  ),
                                  title: Text(
                                    '${callog.name == "" || callog.name == null ? callog.number : callog.name}',
                                    style: TextStyle(
                                        fontSize: callog.name == "" ||
                                                callog.name == null
                                            ? 12
                                            : 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          callog.callType == CallType.outgoing
                                              ? Image.asset(
                                                  'assets/up.png',
                                                  width: 15,
                                                  color: Colors.green,
                                                )
                                              : callog.callType ==
                                                      CallType.missed
                                                  ? Image.asset(
                                                      'assets/rise.png',
                                                      width: 15,
                                                      color: Colors.red,
                                                    )
                                                  : Transform.rotate(
                                                      angle: 3.14159 * 6 / -2,
                                                      child: Image.asset(
                                                        'assets/up.png',
                                                        width: 15,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${callog.simDisplayName} ${controller.formatTimestamp(timestamp)}',
                                                style: TextStyle(
                                                    color: callog.callType ==
                                                            CallType.missed
                                                        ? Colors.red
                                                        : Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      // Text(
                                      //   '${}',
                                      //   style: TextStyle(fontSize: 25),
                                      // ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.directCaller.makePhoneCall(
                                          callog.number ?? "",
                                          simSlot: 1);
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
                                      child: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                  ],
                ),
              ),
      );
    });
  }
}
