import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item_model.dart';

part 'order_model.g.dart';


//Vamos utilizar este model para quando finalizar o pedido
@JsonSerializable()
class OrderModel{

  //Atributos
  String id;
  DateTime? createdDateTime;

  @JsonKey(name: 'due')
  DateTime overDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  String status;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;

  double total;
  String qrCodeImage;

  //Construtor
  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.overDateTime,
    required this.items,
    required this.status,
    required this.qrCodeImage,
    required this.copyAndPaste,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json)=> _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel{id: $id, createdDateTime: $createdDateTime, overDateTime: $overDateTime, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total, qrCodeImage: $qrCodeImage}';
  }

}