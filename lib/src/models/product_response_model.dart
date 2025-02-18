import 'dart:convert';

ProductResponseModel productResponseModelFromJson(String str) =>
    ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) =>
    json.encode(data.toJson());

class ProductResponseModel {
  String? productId;
  String? productName;
  String? productAlias;
  String? distributorCode;
  String? productSize;
  int? priorityOrder;
  double? listPrice;
  double? discountQuantity;
  double? discountedPrice;
  String? mskuCode;
  String? productFamily;

  ProductResponseModel({
    this.productId,
    this.productName,
    this.productAlias,
    this.distributorCode,
    this.productSize,
    this.priorityOrder,
    this.listPrice,
    this.discountQuantity,
    this.discountedPrice,
    this.mskuCode,
    this.productFamily,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        productId: json["product_id"],
        productName: json["product_name"],
        productAlias: json["product_alias"],
        distributorCode: json["distributor_code"],
        productSize: json["product_size"],
        // Convert priorityOrder to int, handling both int and double
        priorityOrder: (json["priority_order"] is double)
            ? (json["priority_order"] as double).toInt()
            : json["priority_order"] as int?,
        listPrice: _parseDouble(json["list_price"]),
        discountQuantity: _parseDouble(json["discount_quantity"]),
        discountedPrice: _parseDouble(json["discounted_price"]),
        mskuCode: json["msku_code"],
        productFamily: json["product_family"],
      );

  static double? _parseDouble(dynamic value) {
    if (value is String) {
      if (value.isEmpty) return null;
      try {
        return double.tryParse(value);
      } catch (e) {
        return null;
      }
    } else if (value is double) {
      return value;
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_alias": productAlias,
        "distributor_code": distributorCode,
        "product_size": productSize,
        "priority_order": priorityOrder,
        "list_price": listPrice,
        "discount_quantity": discountQuantity,
        "discounted_price": discountedPrice,
        "msku_code": mskuCode,
        "product_family": productFamily,
      };
}
