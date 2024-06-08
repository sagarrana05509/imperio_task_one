import 'package:get/get.dart';
import 'package:imperio_task_one_demo/screens/home_screen/home_screen.dart';
import 'package:imperio_task_one_demo/screens/home_screen/home_screen_bindings.dart';


part 'app_routes.dart';

class AppPages {
  static final routes = [
GetPage(name: Routes.HOME, page: ()=> HomeView(),binding: HomeScreenBindings())
  ];
  static List lst  = [];

}
