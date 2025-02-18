import 'package:chakra/src/models/order_response_model.dart';
import 'package:flutter/material.dart';

class BuildOrdersPageItemWidget extends StatefulWidget {
  final OrderResponseModel order;
  const BuildOrdersPageItemWidget({super.key, required this.order});

  @override
  State<BuildOrdersPageItemWidget> createState() =>
      _BuildOrdersPageItemWidgetState();
}

class _BuildOrdersPageItemWidgetState extends State<BuildOrdersPageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(16.0), // Curved corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            // Text(
            //   "Order ID: ${widget.order.orderId ?? 'N/A'}",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            // ),
            // SizedBox(height: 8),
            // User ID
            // Text(
            //   "User ID: ${widget.order.userId ?? 'N/A'}",
            //   style: TextStyle(fontSize: 14, color: Colors.black54),
            // ),
            // SizedBox(height: 8),
            // Created At
            // Text(
            //   "Created At: ${widget.order.createdAt?.toLocal().toString() ?? 'N/A'}",
            //   style: TextStyle(fontSize: 14, color: Colors.black54),
            // ),
            // SizedBox(height: 8),
            // Distributor ID
            // Text(
            //   "Distributor ID: ${widget.order.distributorId ?? 'N/A'}",
            //   style: TextStyle(fontSize: 14, color: Colors.black54),
            // ),
            // SizedBox(height: 8),
            // // Store ID
            // Text(
            //   "Store ID: ${widget.order.storeId ?? 'N/A'}",
            //   style: TextStyle(fontSize: 14, color: Colors.black54),
            // ),
            // SizedBox(height: 8),
            // Product ID
            Text(
              "${widget.order.productAlias ?? 'N/A'}",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 8),
            // Product Quantity
            Text(
              "Product Quantity: ${widget.order.productQuantity?.toString() ?? 'N/A'}",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 8),
            // Product Total Price
            Text(
              "Price: ₹${widget.order.productTotalPrice?.toStringAsFixed(2) ?? '0.00'}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
