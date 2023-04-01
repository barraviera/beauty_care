// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      item: ItemModel.fromJson(json['product'] as Map<String, dynamic>),
      id: json['id'] as String,
      quantity: json['quantity'] as int,
      isConfirmed: json['isConfirmed'] as bool,
      schedule: DateTime.parse(json['schedule'] as String),
      price: (json['price'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'product': instance.item,
      'id': instance.id,
      'quantity': instance.quantity,
      'isConfirmed': instance.isConfirmed,
      'schedule': instance.schedule.toIso8601String(),
      'price': instance.price,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
