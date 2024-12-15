import 'package:call_app/navbar/controller/nav_bar_controller.dart';
import 'package:get/get.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NavBarController());
  }
}
