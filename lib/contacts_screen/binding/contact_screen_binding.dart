import 'package:call_app/contacts_screen/controller/contact_screen_controller.dart';
import 'package:get/get.dart';

class ContactScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ContactScreenController());
  }
}
