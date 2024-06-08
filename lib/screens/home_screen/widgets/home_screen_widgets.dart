import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imperio_task_one_demo/screens/home_screen/home_screen_controller.dart';
import 'package:imperio_task_one_demo/utils/math_utils.dart';
import 'package:imperio_task_one_demo/widgets/base_text.dart';

class SubCategoryView extends GetView<HomeScreenController> {
  const SubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: Colors.white,
          child: Obx(() =>
              ListView.builder(
                  itemCount: controller.subCategoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BaseText(
                              text: controller.subCategoryList[index]
                                  .name!),
                        ),
                        SizedBox(
                          height: getSize(150),
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .subCategoryList[index].product!.length,
                              itemBuilder: (BuildContext context,
                                  int prodIndex) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        width: getSize(90),
                                        height: getSize(80),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                .subCategoryList[index]
                                                .product![prodIndex]
                                                .imageName!,fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: getSize(10),),
                                      BaseText(
                                        text: controller
                                            .subCategoryList[index]
                                            .product![prodIndex].name!,
                                        fontSize: 12,)
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  })),
        ));
  }
}
class CategoryView extends GetView<HomeScreenController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(60),
      width: Get.width,
      child: Obx(() =>
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: getSize(30)),
              itemCount: controller.categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(right: getSize(20)),
                  child: GestureDetector(
                    onTap: () => controller.categoryOnTap(index),
                    child: Obx(() =>
                        BaseText(
                          text: controller.categoryList[index].name!,
                          textColor:
                          controller.selectedCategory.value == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        )),
                  ),
                );
              })),
    );
  }
}

