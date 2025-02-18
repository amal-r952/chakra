import 'package:cloud_firestore/cloud_firestore.dart';

class OrderResponseModel {
  String? orderId;
  String? userId;
  DateTime? createdAt; // Should be a DateTime
  String? distributorId;
  String? storeId;
  String? productId;
  String? productAlias;
  double? productQuantity;
  double? productTotalPrice;

  OrderResponseModel({
    this.orderId,
    this.userId,
    this.createdAt,
    this.distributorId,
    this.storeId,
    this.productId,
    this.productAlias,
    this.productQuantity,
    this.productTotalPrice,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        orderId: json["order_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] != null
            ? (json["created_at"] is Timestamp
                ? (json["created_at"] as Timestamp)
                    .toDate() // Convert Timestamp to DateTime
                : DateTime.parse(
                    json["created_at"])) // In case it's a string, parse it
            : null,
        distributorId: json["distributor_id"],
        storeId: json["store_id"],
        productId: json["product_id"],
        productAlias: json["product_alias"],
        productQuantity: json["product_quantity"]?.toDouble(),
        productTotalPrice: json["product_total_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "distributor_id": distributorId,
        "store_id": storeId,
        "product_id": productId,
        "product_alias": productAlias,
        "product_quantity": productQuantity,
        "product_total_price": productTotalPrice,
      };
}
