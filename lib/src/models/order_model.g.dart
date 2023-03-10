// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      createdDateTime: json['createdDateTime'] == null
          ? null
          : DateTime.parse(json['createdDateTime'] as String),
      overDateTime: DateTime.parse(json['due'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      qrCodeImage: json['qrCodeImage'] as String,
      copyAndPaste: json['copiaecola'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
      'due': instance.overDateTime.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'copiaecola': instance.copyAndPaste,
      'total': instance.total,
      'qrCodeImage': instance.qrCodeImage,
    };
