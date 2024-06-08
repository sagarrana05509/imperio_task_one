import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperio_task_one_demo/screens/home_screen/home_screen_controller.dart';
import 'package:imperio_task_one_demo/utils/math_utils.dart';

import 'widgets/home_screen_widgets.dart';

class HomeView extends GetView<HomeScreenController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          SizedBox(
            height: getSize(30),
          ),
          const CategoryView(),
          const SubCategoryView()
        ],
      ),
    );
  }
}
