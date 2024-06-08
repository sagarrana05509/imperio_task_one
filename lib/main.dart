
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app_binding.dart';
import 'routes/app_pages.dart';
import 'shared/constants/color_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //   statusBarColor: Colors.cyan,
  // ));

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  // SocketService.connectSocket();
  runApp(const App());
  configLoading();
}

//This is the root of out application
class App extends StatelessWidget {
  //final brightness = SchedulerBinding.instance.window.platformBrightness;

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final prefs = Get.find<SharedPreferences>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      defaultTransition: Transition.native,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'imperio_test_one',
      supportedLocales: [
        const Locale('en', 'US'),
      ],

      builder: EasyLoading.init(),
    );

  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
  // ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorSize = 20
  // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.black
    ..indicatorColor = ColorConstants.white
    ..textColor = ColorConstants.white
    ..maskColor = ColorConstants.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
  // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..successWidget = Container(
      height: 100,
      width: 100,
      color: Colors.blue,
    );
}
