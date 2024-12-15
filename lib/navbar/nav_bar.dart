import 'package:call_app/contacts_screen/contacts_screen.dart';
import 'package:call_app/dialer_pad/dialer_pad.dart';
import 'package:call_app/home/home_screen.dart';
import 'package:call_app/navbar/controller/nav_bar_controller.dart';
import 'package:call_e_log/call_log.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return Scaffold(
          body: PersistentTabView(
        avoidBottomPadding: true,
        hideNavigationBar: false,
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              Get.toNamed('/dialer');
            },
            child: const Icon(
              Icons.dialpad_outlined,
              color: Colors.white,
            )),
        tabs: [
          PersistentTabConfig(
            screen: HomeScreen(),
            item: ItemConfig(
              activeForegroundColor: Colors.white,
              icon: Icon(Icons.call),
              title: "Call Logs",
            ),
          ),
          PersistentTabConfig(
            screen: ContactsScreen(),
            item: ItemConfig(
              activeForegroundColor: Colors.white,
              icon: Icon(Icons.person),
              title: "Contacts",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style8BottomNavBar(
          navBarDecoration: NavBarDecoration(
            color: Colors.orange,
            boxShadow: [
              BoxShadow(color: Colors.grey),
            ],
          ),
          navBarConfig: navBarConfig,
        ),
      ));
    });
  }
}
