import 'package:call_app/home/controller/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> HomeScreenController());
  }

}