import 'package:chakra/src/models/order_response_model.dart';
import 'package:chakra/src/models/product_response_model.dart';
import 'package:chakra/src/utils/object_factory.dart';
import 'package:chakra/src/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/font_family.dart';

class BuildHomeListingItemWidget extends StatefulWidget {
  final ProductResponseModel productResponseModel;
  final String storeId;
  final OrderResponseModel orderResponseModel;
  final Function(OrderResponseModel) onOrderUpdated;

  const BuildHomeListingItemWidget({
    super.key,
    required this.productResponseModel,
    required this.orderResponseModel,
    required this.storeId,
    required this.onOrderUpdated,
  });

  @override
  State<BuildHomeListingItemWidget> createState() =>
      _BuildHomeListingItemWidgetState();
}

class _BuildHomeListingItemWidgetState
    extends State<BuildHomeListingItemWidget> {
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text =
        widget.orderResponseModel.productQuantity?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Default list price
    double priceToUse = widget.productResponseModel.listPrice ?? 0;
    double totalPrice = 0.0;

    bool isQuantityEligibleForDiscount =
        widget.orderResponseModel.productQuantity != null &&
            widget.orderResponseModel.productQuantity! >=
                (widget.productResponseModel.discountQuantity ?? 0);

    // Use a default value if productQuantity is null
    double productQuantity = widget.orderResponseModel.productQuantity ?? 0.0;

    // If quantity is eligible for discount, use discounted price for D/P/T
    if (isQuantityEligibleForDiscount) {
      priceToUse = widget.productResponseModel.discountedPrice ?? 0;
      totalPrice = productQuantity * priceToUse;
    } else {
      // Otherwise, calculate using listPrice
      priceToUse = widget.productResponseModel.listPrice ?? 0;
      totalPrice = productQuantity * priceToUse;
    }

    double discountedTotalPrice =
        productQuantity * (widget.productResponseModel.discountedPrice ?? 0);
    double listPriceTotalPrice =
        productQuantity * (widget.productResponseModel.listPrice ?? 0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product information
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.productResponseModel.productAlias ?? ' ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.productResponseModel.productSize ?? ' ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Scheme Quantity: ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text:
                                  "${widget.productResponseModel.discountQuantity ?? '--'}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.accentColor.withOpacity(0.3)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                        Text(widget.productResponseModel.productFamily ?? ' '),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                      width: screenWidth(context, dividedBy: 4),
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          counterStyle: const TextStyle(
                            height: double.minPositive,
                          ),
                          filled: true,
                          fillColor: AppColors.textFieldFillColour,
                          labelText: "Enter qty",
                          labelStyle: TextStyle(
                            color: AppColors.mediumGrey,
                            fontFamily: FontFamily.gothamBook,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                            gapPadding: 0,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                            gapPadding: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGrey,
                            ),
                            gapPadding: 0,
                          ),
                        ),
                        onChanged: (value) {
                          double? newQuantity;

                          // If the input is null or empty, set it to 0
                          if (value.isEmpty) {
                            newQuantity = 0;
                          } else {
                            // Try parsing the input as a double
                            newQuantity = double.tryParse(value);
                          }

                          // Proceed if we have a valid quantity
                          if (newQuantity != null) {
                            double priceToUse = (widget.productResponseModel
                                            .discountQuantity !=
                                        null &&
                                    newQuantity >=
                                        widget.productResponseModel
                                            .discountQuantity!)
                                ? widget.productResponseModel.discountedPrice ??
                                    0
                                : widget.productResponseModel.listPrice ?? 0;

                            OrderResponseModel updatedOrder =
                                OrderResponseModel(
                              orderId:
                                  "${ObjectFactory().appHive.getUserId()}-${widget.productResponseModel.productId}-${ObjectFactory().appHive.getDistributorId()}-${DateTime.now().millisecondsSinceEpoch.toString()}",
                              userId: ObjectFactory().appHive.getUserId(),
                              productAlias:
                                  widget.productResponseModel.productAlias,
                              createdAt: DateTime.now(),
                              distributorId:
                                  ObjectFactory().appHive.getDistributorId(),
                              storeId: widget.storeId,
                              productId: widget.productResponseModel.productId,
                              productQuantity: newQuantity,
                              productTotalPrice: newQuantity * priceToUse,
                            );

                            widget.onOrderUpdated(updatedOrder);
                          }
                        },
                      )),
                  SizedBox(width: 15),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "S/P: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Lighter style
                                ),
                                TextSpan(
                                  text:
                                      "${widget.productResponseModel.discountedPrice?.toString() ?? '--'}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge, // Bolder style
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "L/P: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Lighter style
                                ),
                                TextSpan(
                                  text:
                                      "${widget.productResponseModel.listPrice?.toString() ?? '--'}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge, // Bolder style
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show Discounted Price Total (D/P/T)
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "S/P Total: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Lighter style
                                ),
                                TextSpan(
                                  text:
                                      "${isQuantityEligibleForDiscount ? discountedTotalPrice : '--'}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge, // Bolder style
                                ),
                              ],
                            ),
                          ),

                          // Show List Price Total (L/P/T) with strike-through if discount is applied
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "L/P Total: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Lighter style
                                ),
                                TextSpan(
                                  text:
                                      "${productQuantity > 0 ? listPriceTotalPrice : 0}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        decoration:
                                            (isQuantityEligibleForDiscount &&
                                                    widget.productResponseModel
                                                            .discountQuantity !=
                                                        null)
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
