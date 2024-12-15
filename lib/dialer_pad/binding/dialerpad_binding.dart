import 'package:call_app/dialer_pad/controller/dialer_pad_controller.dart';
import 'package:get/get.dart';

class DialerPadBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DialerPadController());
  }
}
