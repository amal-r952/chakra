import 'dart:convert';

StoreResponseModel storeResponseModelFromJson(String str) =>
    StoreResponseModel.fromJson(json.decode(str));

String storeResponseModelToJson(StoreResponseModel data) =>
    json.encode(data.toJson());

class StoreResponseModel {
  String? storeId;
  String? storeType;
  String? storeName;
  String? distributorId;
  String? userId;

  StoreResponseModel({
    this.storeId,
    this.storeType,
    this.storeName,
    this.distributorId,
    this.userId,
  });

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreResponseModel(
        storeId: _convertToString(json["store_id"]),
        storeType: _convertToString(json["store_type"]),
        storeName: _convertToString(json["store_name"]),
        distributorId: _convertToString(json["distributor_id"]),
        userId: _convertToString(json["user_id"]),
      );

// Helper function to safely convert a value to a String
  static String? _convertToString(dynamic value) {
    if (value is String) {
      return value; // If it's already a String, return it
    } else if (value is double) {
      return value.toString(); // Convert double to String
    }
    return null; // Return null if the value is neither String nor double
  }

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "store_type": storeType,
        "store_name": storeName,
        "distributor_id": distributorId,
        "user_id": userId,
      };
}
