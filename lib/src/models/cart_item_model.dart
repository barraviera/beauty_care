import 'package:beauty_care/src/models/item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {

  //atributos
  @JsonKey(name: 'product')
  ItemModel item;
  String id;
  int quantity;

  //construtor
  CartItemModel({
    required this.item,
    required this.id,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

  //retorno do tipo Map<String, dynamic>
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  double totalPrice() => item.price * quantity;

  @override
  String toString() {
    return 'CartItemModel{item: $item, id: $id, quantity: $quantity}';
  }
}