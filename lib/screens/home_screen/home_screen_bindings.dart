import 'package:get/get.dart';
import 'package:imperio_task_one_demo/screens/home_screen/home_screen_controller.dart';

class HomeScreenBindings extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut<HomeScreenController>(()=> HomeScreenController(apiRepository: Get.find()));
  }
}