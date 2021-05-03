import 'package:hmart/models/cart_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final List<CartItem> cart;
  Cart({this.cart});
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
