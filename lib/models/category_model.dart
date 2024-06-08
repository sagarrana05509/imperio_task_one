// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final int? id;
  final String? name;
  final int? isAuthorize;
  final int? update080819;
  final int? update130919;
  final List<SubCategory>? subCategories;

  CategoryModel({
    this.id,
    this.name,
    this.isAuthorize,
    this.update080819,
    this.update130919,
    this.subCategories,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    int? isAuthorize,
    int? update080819,
    int? update130919,
    List<SubCategory>? subCategories,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isAuthorize: isAuthorize ?? this.isAuthorize,
        update080819: update080819 ?? this.update080819,
        update130919: update130919 ?? this.update130919,
        subCategories: subCategories ?? this.subCategories,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["Id"],
    name: json["Name"],
    isAuthorize: json["IsAuthorize"],
    update080819: json["Update080819"],
    update130919: json["Update130919"],
    subCategories: json["SubCategories"] == null ? [] : List<SubCategory>.from(json["SubCategories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "IsAuthorize": isAuthorize,
    "Update080819": update080819,
    "Update130919": update130919,
    "SubCategories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  final int? id;
  final String? name;
  final List<Product>? product;

  SubCategory({
    this.id,
    this.name,
    this.product,
  });

  SubCategory copyWith({
    int? id,
    String? name,
    List<Product>? product,
  }) =>
      SubCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        product: product ?? this.product,
      );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["Id"],
    name: json["Name"],
    product: json["Product"] == null ? [] : List<Product>.from(json["Product"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class Product {
  final String? name;
  final String? priceCode;
  final String? imageName;
  final int? id;

  Product({
    this.name,
    this.priceCode,
    this.imageName,
    this.id,
  });

  Product copyWith({
    String? name,
    String? priceCode,
    String? imageName,
    int? id,
  }) =>
      Product(
        name: name ?? this.name,
        priceCode: priceCode ?? this.priceCode,
        imageName: imageName ?? this.imageName,
        id: id ?? this.id,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}
