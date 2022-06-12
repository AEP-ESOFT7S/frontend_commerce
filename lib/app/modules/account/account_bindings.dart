import 'package:get/get.dart';
import './account_controller.dart';

class AccountBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AccountController());
    }
}