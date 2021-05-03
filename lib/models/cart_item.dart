import 'dart:core';

import 'package:hmart/models/cart.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final String productID;
  CartItem({
    this.productID,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
